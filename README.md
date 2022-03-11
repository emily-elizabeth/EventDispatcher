# EventDispatcher
 A notification dispatch mechanism that enables the broadcast of information to registered observers.

## Add a new observer
 EventDispatcher.AddObserver _observer, notificationName_  
 * _observer_ is the Xojo object that will receive the notification  
 * _notificationName_ is the name of the method that will be run when the notification is received  
 
Example:
 `EventDispatcher.AddObserver Window1, "MyMethod"`
 
## Remove an observer
 EventDispatcher.RemoveObserver _observer, notificationName_  
 * _observer_ is the Xojo object that will stop receiving the notification
 * _notificationName_ is the name of the notification that you are no longer listening for

Example:  
 `EventDispatcher.RemoveObserver Window1, "MyMethod"`  

## Post a notification
 EventDispatcher.Notify _sender, notificationName_  
 EventDispatcher.Notify _sender, notificationName, userInfo_  
 * _sender_ is the Xojo object sending the notification, set to Nil if not needed or sending from a module
 * _notificationName_ is the name of the notification that is being broadcast
 * _userInfo_ is a list of optional parameters to be sent with the broadcast  

Example:  
 `EventDispatcher.Notify Window1, "MyMethod"  // no userInfo parameters being sent  `
 `EventDispatcher.Notify Window1, "MyMethod2", "hello", "world"  // two parameters being sent`
 
## Note
The first parameter of the callback method will be the sender, followed by any additional parameters
