extends Node

#Error types
enum errortype {Normal, Error, Fail, Info, Correct}

#region Log message type
func MessageLog(Message:String,error : errortype):
	match error:
		errortype.Normal:
			print(Message)
		errortype.Error:
			printerr(Message)
		errortype.Fail:
			print_rich("[color=CORAL]FAIL: [/color]" + Message)
		errortype.Info:
			print_rich("[color=YELLOW]INFO: [/color]" + Message)
		errortype.Correct:
			print_rich("[color=GREEN]CORRECT: [/color]" + Message)
#endregion

#region Error log data
func ErrorString(ErrorInt : int) -> String:
	return error_string(ErrorInt)
#endregion
