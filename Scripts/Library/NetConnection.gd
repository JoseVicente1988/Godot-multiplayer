extends Node

var eNet = ENetMultiplayerPeer.new()

#region Client connection.
func ClientConnection(ip : String,Port : int):
	var error = eNet.create_client(ip,Port)
	if error == OK:
		multiplayer.multiplayer_peer = eNet
		#region Log message.
		Commands.MessageLog("Conexión establecida.",Commands.errortype.Correct)
		Commands.MessageLog("Te conectaste con la id: " + str(eNet.get_unique_id()) + ".",Commands.errortype.Info)
		#endregion
		#give 0.5 seconds to connect the client before
		await get_tree().create_timer(0.5).timeout
		MessageToServer.rpc_id(1,"El jugador con la id: " + str(eNet.get_unique_id()) + " se conectó.")
	else:
		Commands.MessageLog("Fallo con la conexión. Error tipo: " + Commands.ErrorString(error) + ".",Commands.errortype.Fail)
#endregion

#region Listen server.
func ServerListen(Port : int,MaxClients : int = 4095):
	var error = eNet.create_server(Port,MaxClients)
	if error == OK:
		multiplayer.multiplayer_peer = eNet
		#region Log message.
		Commands.MessageLog("Servidor activo.",Commands.errortype.Correct)
		Commands.MessageLog("El servidor esta en escucha, los jugadores podran conectarse ahora.",Commands.errortype.Info)
		#endregion
	else:
		Commands.MessageLog("No se inició el servidor error tipo: " + Commands.ErrorString(error) + ", tratando de volver a conectar.",Commands.errortype.Error)
		#region retry
		eNet.close()
		ServerListen(Port,MaxClients)
		#endregion
#endregion

#region Send the message to server
@rpc("any_peer","call_local")
func MessageToServer(Message:String):
	var data = Message
	if multiplayer.is_server():
		Commands.MessageLog(data,Commands.errortype.Info)
#endregion
