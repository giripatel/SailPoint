import java.net.http.HttpRequest;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpResponse;
import java.net.http.HttpClient;
import java.io.IOException;

class Request {
   
  public static void main(String[] args) throws URISyntaxException, IOException{
  
    try {

//  .POST(HttpRequest.BodyPublishers.ofString("Sample request body"))
  HttpRequest request = HttpRequest.newBuilder()
  .uri(new URI("http://localhost:3000/"))
  .headers("Content-Type", "text/plain;charset=UTF-8")
  .GET()
  .build();
    HttpResponse<String> response = HttpClient.newHttpClient()
    .send(request, HttpResponse.BodyHandlers.ofString());
    System.out.println("Response from URI: "+response.uri());
    System.out.println("Response from toString: "+response.toString());
    System.out.println("Response body: "+ response.body());
    } catch (Exception e) {
      System.out.println("Exception : " + e);
    }
  }
}
