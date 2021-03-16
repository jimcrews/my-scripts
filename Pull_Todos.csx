/// <summary>
/// Pull Todos from https://jsonplaceholder.typicode.com/todos
/// 
/// To be used as example code
/// 
/// </summary>
#r "Newtonsoft.Json.dll"

using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;

public class Todos {
    public int userId { get; set; }
    public int id { get; set; }
    public string title { get; set; }
    public bool completed { get; set; }

}



public static IEnumerable<T> GetData<T>(string url)
{
    WebClient client = new WebClient();
    client.UseDefaultCredentials = true;
    var response = client.DownloadString(url);
    var obj = JsonConvert.DeserializeObject<IEnumerable<T>>(response);
    return obj;
}

public static void main()
{


    var todosList = GetData<Todos>("https://jsonplaceholder.typicode.com/todos");


    foreach (var item in todosList){
        

        Console.WriteLine("user id = {0}", item.userId);
        Console.WriteLine("id = {0}", item.id);
        Console.WriteLine("title = {0}", item.title);
        Console.WriteLine("completed = {0}", item.completed);
        Console.WriteLine("\n");

    }
}

main();