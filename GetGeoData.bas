Function GetGeoData(sSearch as String) as String
   If Len(sSearch) = 0 Then Exit Function 'we dont need empty cells <img draggable="false" class="emoji" alt="😉" src="https://s.w.org/images/core/emoji/2.3/svg/1f609.svg">
   'URL = "http://maps.googleapis.com/maps/api/geocode/xml?sensor=false&address="  'we will use the google maps api
   api_key = "API_KEY"
   URL = "https://maps.googleapis.com/maps/api/geocode/xml?address="  'we will use the google maps api
   URL = URL & sSearch & "&key=" & api_key          'create the searchstring
   oSimpleFileAccess = createUnoService( "com.sun.star.ucb.SimpleFileAccess" ) 'this is the Sefvice in getting the data from the web
   On Error GoTo ErrorResponse
   oInputStream = oSimpleFileAccess.openFileRead(URL) 'use the URL
   oTextStream = createUnoService("com.sun.star.io.TextInputStream") 'get the data from the web
   oTextStream.InputStream = oInputStream 'this is the data
   aDelimiters = Array(ASC(">"),ASC("<")) 'as the stream is segmented with ">" and "<"
   sLastString = ""
   sLat = ""
   sLon  = ""
   Do While NOT oTextStream.isEOF 'go through the google output
      sThisString = oTextStream.readString(aDelimiters,True) 
      Select Case sLastString 'now search for the entries
         Case "lat": 'latitudes
         	If sLat = "" Then sLat = sThisString  
         Case "lng": 'longitude
            If sLon = "" Then sLon = sThisString
      End Select
      sLastString = sThisString
   Loop
   oSheet= thiscomponent.getcurrentcontroller.activesheet
   oCell = ThisComponent.getCurrentSelection()
   column = oCell.CellAddress.Column
   row = oCell.CellAddress.Row

   Doc = ThisComponent
   Sheet = Doc.Sheets(0)   
   GetGeoData = esLon & "_" & sLat'this is our output in  the new cell
   oInputStream.closeInput()
   oTextStream.closeInput()
   Exit Function
   ErrorResponse:
   GetGeoData = Error & "no values found!!!"
End Function
