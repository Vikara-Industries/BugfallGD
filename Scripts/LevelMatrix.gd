extends Node
class_name LevelMatrix

const NUM_BLOCKS_IN_ROW = 5
const NUM_ROWS = 5
var levelRows :Array 
var RowVisibilityState: Array

func _ready():
	for row in get_children():
		levelRows.append(row.get_children())
	for i in NUM_ROWS-1:
		pushNewRowFromBottom()

func setRowState(rowIndex, RowVisState):
	for i in NUM_BLOCKS_IN_ROW:
		levelRows[rowIndex][i].set_visible(RowVisState[i])
		if RowVisState[i] == false:
			levelRows[rowIndex][i].set_collision_layer_value(1, false)
		else:
			levelRows[rowIndex][i].set_collision_layer_value(1, true)
		
	
func getRowState(rowIndex):
	var rowState :Array
	for floorTile in levelRows[rowIndex]:
		rowState.append(floorTile.is_visible())
	return rowState.duplicate()
	
func pushNewRowFromBottom(Row = null):
	var newRow = Row
	if newRow == null:
		newRow = generateRandomRowState()
	for i in levelRows.size():
		if i == levelRows.size()-1:
			setRowState(i, newRow)
		else:
			setRowState(i, getRowState(i+1))
			
func generateRandomRowState():
	var randRow :Array
	for i in NUM_BLOCKS_IN_ROW:
		if randf() >0.4:
			randRow.append(true)
		else:
			randRow.append(false)
	
	
	
	var hasHole = false
	for visibility in randRow:
		if visibility == false:
			hasHole = true
	if not hasHole:
		randRow[randi_range(0,NUM_BLOCKS_IN_ROW-1)] = false
		
	return randRow
	
func _input(event):
	if event is InputEventKey and event.keycode == KEY_ENTER and event.is_released():
		pushNewRowFromBottom()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
