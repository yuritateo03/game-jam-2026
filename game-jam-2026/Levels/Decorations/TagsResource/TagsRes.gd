extends Resource
class_name TagsRes

@export var name : String

@export_enum("Up","Center","Down") var position : int
@export_enum("Horror","Cute","Elegant") var theme : int
@export var colors : Array[ColorTag]
@export var subthemes : Array[SubThemeTag]
