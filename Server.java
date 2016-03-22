import io.vertx.core.AbstractVerticle;
import io.vertx.core.Vertx;
import io.vertx.core.VertxOptions;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.handler.StaticHandler;

/*
 * @author <a href="http://tfox.org">Tim Fox</a>
 */
public class Server extends AbstractVerticle {

    public static void main(String[] args) {

        Vertx.vertx( new VertxOptions() )
                .deployVerticle( new Server() );
    }

    @Override
    public void start() throws Exception {

        Router router = Router.router( vertx );

        router.get("/test").handler( routingContext -> {

            routingContext
                    .response()
                    .putHeader("Content-Type", "text/html")
                    .end("<h1>HelloWorld</h1>");
        });

        router.get("/").handler( StaticHandler.create("").setCachingEnabled(false) );


        vertx
                .createHttpServer()
                .requestHandler( router::accept )
                .listen(8080);

        System.out.println( "Server started..." );
    }

    public void stop() throws Exception {

        System.out.println( "Server shutdown..." );
    }
}