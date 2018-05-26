function fillsgenre()
  {
    $.ajax({
      url: '/getsubgenres',
      method: 'get',
      data:{genre_name : $(questions_gname).val()},
      success: function(response)
      {
        var slist=document.getElementById("subgenre_list");
        $('#subgenre_list').empty()
        
        var x = document.createElement("OPTION");
        x.setAttribute("value", "");
        var t = document.createTextNode("Select Subgenre");
        x.appendChild(t);
        slist.appendChild(x);
        for(var i in response)
        {
          var x = document.createElement("OPTION");
          x.setAttribute("value", response[i].name);
          var t = document.createTextNode(response[i].name);
          x.appendChild(t);
          slist.appendChild(x);
        }
      },
      error: function(response)
      {
        console.log(response);
        console.log("error");
      },
    });
  }