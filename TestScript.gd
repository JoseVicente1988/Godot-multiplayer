extends Control

#region Boton que conecta con el servidor
func _on_cliente_button_pressed():
	Connections.ClientConnection("127.0.0.1",80)
#endregion

#region Crea el servidor
func _on_server_button_pressed():
	Connections.ServerListen(80)
#endregion
