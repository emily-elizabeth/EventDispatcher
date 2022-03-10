#tag Module
Protected Module EventDispatcher
	#tag Method, Flags = &h1
		Protected Sub AddObserver(observer As Object, notification As String)
		  // observer
		  //     Object registering as an observer. This value must not be nil.
		  //
		  // notification
		  //     The name of the notification the observer is registering.
		  //     Notification names can be any string, so long as they follow the same naming convention for method names
		  //
		  // notes
		  //     observers are stored based on the notification they want to receive
		  //     weak references are used, so as not to keep a reference to the observer
		  //     when the notification a method with the notification name will be called
		  
		  
		  DIM observersDict As Dictionary = mNotificationObserversDict.Lookup(notification, NEW Dictionary)
		  
		  DIM observerWeakRef As WeakRef = NEW WeakRef(observer)
		  if (observersDict.HasKey(observerWeakRef) = FALSE) then     // only add the observer once
		    observersDict.Value(observerWeakRef) = notification
		    mNotificationObserversDict.Value(notification) = observersDict
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Notify(sender As Object, notification As String, ParamArray userInfo As Variant)
		  // sender
		  //     The object posting the notification. This value must not be nil.
		  //
		  // notification
		  //     The notification to post. This value must not be nil.
		  //     Notification names can be any string, so long as they follow the same naming convention for method names.
		  //
		  // userInfo
		  //     Information about the the notification. This value can be Nil.
		  
		  
		  DIM observersDict As Dictionary = mNotificationObserversDict.Lookup(notification, NEW Dictionary)
		  DIM observersDictClone As Dictionary = observersDict.Clone
		  
		  DIM params() As Variant
		  params.Append sender
		  if (UBound(userInfo) > -1) then
		    for each item As Auto in userInfo
		      params.Append item
		    next
		  end if
		  
		  if (observersDictClone.Count > 0) then
		    for each entry As DictionaryEntry in observersDictClone
		      DIM observerWeakRef As WeakRef = entry.Key
		      if (observerWeakRef.Value = Nil) then
		        observersDict.Remove observerWeakRef
		      else
		        DIM observer As Object = observerWeakRef.Value
		        DIM methods() As Introspection.MethodInfo = Introspection.GetType(observer).GetMethods
		        for each method As Introspection.MethodInfo in methods
		          if (method.Name = entry.Value) then
		            method.Invoke observer, params
		          end if
		        next method
		      end if
		    next
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RemoveObserver(observer As Object, notification As String)
		  // observer
		  //     Observer to remove from the dispatch table.
		  //
		  // notificationName
		  //     Name of the notification to remove from dispatch table.
		  //     Notification names can be any string.
		  
		  
		  DIM observersDict As Dictionary = mNotificationObserversDict.Lookup(notification, NEW Dictionary)
		  DIM observersDictClone As Dictionary = observersDict.Clone
		  
		  DIM observerWeakRef As WeakRef = NEW WeakRef(observer)
		  if (observersDictClone.HasKey(observerWeakRef)) then
		    observersDictClone.Remove observerWeakRef
		    mNotificationObserversDict.Value(notification) = observersDictClone
		  end if
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static mNotificationDict As NEW Dictionary
			  Return mNotificationDict
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #Pragma Unused value
			End Set
		#tag EndSetter
		Private mNotificationObserversDict As Dictionary
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
