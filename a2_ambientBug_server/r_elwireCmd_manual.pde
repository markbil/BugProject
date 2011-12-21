void elwireCmd_manual(WebServer &server, WebServer::ConnectionType type, char *url_tail, bool tail_complete)
{
  URLPARAM_RESULT rc;
  char name[NAMELEN];
  int  name_len;
  char value[VALUELEN];
  int value_len;
  
  int myParameters[4];

  /* this line sends the standard "we're all OK" headers back to the
     browser */
  server.httpSuccess();

  /* if we're handling a GET or POST, we can output our data here.
     For a HEAD request, we just stop after outputting headers. */
  if (type == WebServer::HEAD)
    return;

  server.printP(Page_start);
  switch (type)
    {
    case WebServer::GET:
        server.printP(Get_head);
        break;
    case WebServer::POST:
        server.printP(Post_head);
        break;
    default:
        server.printP(Unknown_head);
    }

    server.printP(Parsed_head);
    server.printP(tail_complete ? Good_tail_begin : Bad_tail_begin);
    server.print(url_tail);
    server.printP(Tail_end);

  if (strlen(url_tail))
    {
    server.printP(Parsed_tail_begin);
    while (strlen(url_tail))
      {
      rc = server.nextURLparam(&url_tail, name, NAMELEN, value, VALUELEN);
      if (rc == URLPARAM_EOS)
        server.printP(Params_end);
       else
        {
        server.print(name);
        server.printP(Parsed_item_separator);
        server.print(value);
        server.printP(Tail_end);
        }
        

        if (strcmp(name, "address") == 0)
        {

          myParameters[0] = atoi(value);
          //server.print(myParameters[0]); 
      
        }
        else if (strcmp(name, "onsec") == 0)
        {
          myParameters[1] = atoi(value);
          //server.print(myParameters[1]); 
        }
        else if (strcmp(name, "offsec") == 0)
        {
          myParameters[2] = atoi(value); 
          //server.print(myParameters[2]);
        }
        else if (strcmp(name, "repetition") == 0)
        {
          myParameters[3] = atoi(value); 
          //server.print(myParameters[3]);
        }
        
      }
      sendToXBee_elwire_manual(myParameters[0], myParameters[1], myParameters[2], myParameters[3]);
    }
    
  if (type == WebServer::POST)
  {
    server.printP(Post_params_begin);
    while (server.nextURLparam(&url_tail, name, NAMELEN, value, VALUELEN))
    {
      server.print(name);
      server.printP(Parsed_item_separator);
      server.print(value);
      server.printP(Tail_end);
    }
  }
  server.printP(Page_end);

}
