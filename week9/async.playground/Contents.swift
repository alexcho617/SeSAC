func saveUD() async{
    
    print("UD Save")
}

func checkServer() async{
    
    print("Server Check")
    
}
func signIn() async{
    //Server 통신
    //UD 저장
    await checkServer()
    await saveUD()
    print("Signin")
}

signIn()
