extends Node

func any(signals: Array[Variant]) -> void:
	await AnySignal.new(signals).completed


func all(signals: Array[Variant]) -> void:
	await AllSignal.new(signals).completed


class AllSignal extends RefCounted:
	class Item extends RefCounted:
		signal finished(item: Item)
		
		var inner_sig: Variant
		
		func _init(sig: Variant) -> void:
			inner_sig = sig
			inner_sig.connect(_on_sig_finished)
		
		func _on_sig_finished() -> void:
			inner_sig.disconnect(_on_sig_finished)
			finished.emit(self)
	
	
	signal completed
	
	var stored_signals: Array[Item] = []
	
	
	func _init(signals: Array[Variant]) -> void:
		for sig: Variant in signals:
			var item := Item.new(sig)
			item.finished.connect(_on_signal_finished)
			stored_signals.append(item)
	
	
	func _on_signal_finished(item: Item) -> void:
		stored_signals.erase(item)
		
		if stored_signals.is_empty():
			completed.emit()
	
	
class AnySignal extends RefCounted:
	signal completed
	
	var stored_signals: Array[Variant] = []
	
	func _init(signals: Array[Variant]) -> void:
		stored_signals = signals
		for sig: Variant in signals:
			sig.connect(_on_signal_finished)
	
	func _on_signal_finished() -> void:
		for sig: Variant in stored_signals:
			sig.disconnect(_on_signal_finished)
		
		completed.emit()
	
