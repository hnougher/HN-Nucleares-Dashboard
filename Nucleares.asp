<%
' This page aggregates the data from the game variables and outputs it as a JSON hashtable
' It takes an array of variables, calls the API at http://localhost:8080/?Variable= and returns the value as the JSON value
' The list of valiables avaialble is at https://nuclearesgame.blogspot.com/2023/11/webserver.html

' Create the array of variables to collect
Dim Variables
Variables = Array( _
	"CORE_TEMP", _
	"CORE_TEMP_OPERATIVE", _
	"CORE_TEMP_MAX", _
	"CORE_TEMP_MIN", _
	"CORE_TEMP_RESIDUAL", _
	"CORE_PRESSURE", _
	"CORE_PRESSURE_MAX", _
	"CORE_PRESSURE_OPERATIVE", _
	"CORE_INTEGRITY", _
	"CORE_WEAR", _
	"CORE_STATE", _
	"CORE_STATE_CRITICALITY", _
	"CORE_CRITICAL_MASS_REACHED", _
	"CORE_CRITICAL_MASS_REACHED_COUNTER", _
	"CORE_IMMINENT_FUSION", _
	"CORE_READY_FOR_START", _
	"CORE_STEAM_PRESENT", _
	"CORE_HIGH_STEAM_PRESENT", _
	"TIME", _
	"TIME_STAMP", _
	"COOLANT_CORE_STATE", _
	"COOLANT_CORE_PRESSURE", _
	"COOLANT_CORE_MAX_PRESSURE", _
	"COOLANT_CORE_VESSEL_TEMPERATURE", _
	"COOLANT_CORE_QUANTITY_IN_VESSEL", _
	"COOLANT_CORE_PRIMARY_LOOP_LEVEL", _
	"COOLANT_CORE_FLOW_SPEED", _
	"COOLANT_CORE_FLOW_ORDERED_SPEED", _
	"COOLANT_CORE_FLOW_REACHED_SPEED", _
	"COOLANT_CORE_QUANTITY_CIRCULATION_PUMPS_PRESENT", _
	"COOLANT_CORE_QUANTITY_FREIGHT_PUMPS_PRESENT", _
	"COOLANT_CORE_CIRCULATION_PUMP_0_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_1_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_2_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_0_DRY_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_1_DRY_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_2_DRY_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_0_OVERLOAD_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_1_OVERLOAD_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_2_OVERLOAD_STATUS", _
	"COOLANT_CORE_CIRCULATION_PUMP_0_ORDERED_SPEED", _
	"COOLANT_CORE_CIRCULATION_PUMP_1_ORDERED_SPEED", _
	"COOLANT_CORE_CIRCULATION_PUMP_2_ORDERED_SPEED", _
	"COOLANT_CORE_CIRCULATION_PUMP_0_SPEED", _
	"COOLANT_CORE_CIRCULATION_PUMP_1_SPEED", _
	"COOLANT_CORE_CIRCULATION_PUMP_2_SPEED", _
	"RODS_STATUS", _
	"RODS_MOVEMENT_SPEED", _
	"RODS_MOVEMENT_SPEED_DECREASED_HIGH_TEMPERATURE", _
	"RODS_DEFORMED", _
	"RODS_TEMPERATURE", _
	"RODS_MAX_TEMPERATURE", _
	"RODS_POS_ORDERED", _
	"RODS_POS_ACTUAL", _
	"RODS_POS_REACHED", _
	"RODS_QUANTITY", _
	"RODS_ALIGNED", _
	"GENERATOR_0_KW", _
	"GENERATOR_1_KW", _
	"GENERATOR_2_KW", _
	"GENERATOR_0_V", _
	"GENERATOR_1_V", _
	"GENERATOR_2_V", _
	"GENERATOR_0_A", _
	"GENERATOR_1_A", _
	"GENERATOR_2_A", _
	"GENERATOR_0_HERTZ", _
	"GENERATOR_1_HERTZ", _
	"GENERATOR_2_HERTZ", _
	"GENERATOR_0_BREAKER", _
	"GENERATOR_1_BREAKER", _
	"GENERATOR_2_BREAKER", _
	"STEAM_TURBINE_0_RPM", _
	"STEAM_TURBINE_1_RPM", _
	"STEAM_TURBINE_2_RPM", _
	"STEAM_TURBINE_0_TEMPERATURE", _
	"STEAM_TURBINE_1_TEMPERATURE", _
	"STEAM_TURBINE_2_TEMPERATURE", _
	"STEAM_TURBINE_0_PRESSURE", _
	"STEAM_TURBINE_1_PRESSURE", _
	"STEAM_TURBINE_2_PRESSURE" _
)

' Function to get the value of a variable from the API
' The response from all http://localhost:8080/?Variable=VariableName calls is a single number
Function GetVariable(Variable)
	Dim objHTTP
	Set objHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
	objHTTP.Open "GET", "http://localhost:8080/?Variable=" & Variable, False
	objHTTP.Send
	GetVariable = objHTTP.responseText
	Set objHTTP = Nothing
End Function

' Output the JSON directly to the browser
Response.ContentType = "application/json"
Response.Write("{")
For i = 0 To UBound(Variables)
	' Output the variable name and value whic is collected from the API
	Response.Write("""" & Variables(i) & """:""" & GetVariable(Variables(i)) & """")

	If i < UBound(Variables) Then
		Response.Write(",")
	End If
Next
Response.Write("}")

%>