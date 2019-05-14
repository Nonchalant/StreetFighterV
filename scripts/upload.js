function upload_environment() {
  // REPLACE ME
  [ENV["SPREADSHEET_EN_JA"], ENV["SPREADSHEET_EN_EN"]].forEach(function(sheetId) {
    var spreadSheet = SpreadsheetApp.openById(sheetId);
    var characters = getCharacters_(spreadSheet);
    var locale = getLocale_(spreadSheet);
    
    characters.forEach(function(character) {
      key = character[0];
      
      uploadJson_(key, locale, getJson_(spreadSheet, character));
    });
  });
}

function getCharacters_(spreadSheet) {
  var sheet = spreadSheet.getSheetByName("キャラクター");  
  return sheet.getDataRange().getValues().slice(1)
}

function getLocale_(spreadSheet) {
  var sheetName = spreadSheet.getName();
  return sheetName.match(/\(([a-z]+)\)/)[0].replace("(", "").replace(")", "");
}

function getJson_(spreadSheet, character) {
  var name = character[1];
  var sequenceId = character[2];
  var season = character[3];

  var sheet = spreadSheet.getSheetByName(name);
  
  var character = {
    "name": name,
    "sequenceId": sequenceId,
    "season": season
  };
      
  var columns = sheet.getDataRange().getValues()[0];
  var rows = sheet.getDataRange().getValues().slice(1);
  
  // Setを重複を取り除いている ([VT1, VT2])
  var setKeys = rows.map(function(row) { return row[0] })
    .filter(function(x, i, self) { return self.indexOf(x) === i; })
    .filter(function(x) { return x !== ""; });

  // Typeを重複を取り除いている ([normalMoves, uniqueAttacks, ..., criticalArts])
  var typeKeys = rows.map(function(row) { return row[1] })
    .filter(function(x, i, self) { return self.indexOf(x) === i; })
    .filter(function(x) { return x !== ""; });
    
  var sets = [];
  
  setKeys.forEach(function(setKey) {
    set = {
      "name": setKey
    };
        
    typeKeys.forEach(function(typeKey) {
      moves = [];

      rows.filter(function(x) { 
        return x[0] == setKey && x[1] == typeKey
      }).forEach(function(row) {
        var move = {};
      
        row.forEach(function(item, index) {
          move[columns[index]] = String(item);
        });
      
        moves.push(move);
      });
      
      set[getTypeName_(typeKey)] = moves;
    });

    sets.push(set);
  });
  
  character["sets"] = sets;
  
  return character;
} 

function getTypeName_(type) {
  switch (type) {
    case "通常技":
    case "Normal Moves":
      return "normalMoves"
    case "特殊技":
    case "Unique Attacks":
      return "uniqueAttacks"
    case "通常投げ":
    case "Normal Throws":
      return "normalThrows"
    case "Vシステム":
    case "V-System":
      return "vSystem"
    case "必殺技":
    case "Special Moves":
      return "specialMoves"
    case "クリティカルアーツ":
    case "Critical Art":
      return "criticalArts"
    default:
      return null
  }
}

function uploadJson_(document, locale, json) {
  // REPLACE ME
  var email = ENV["ENVIRONMENT_FIREBASE_EMAIL"];
  var key = ENV["ENVIRONMENT_FIREBASE_KEY"];
  var projectId = ENV["ENVIRONMENT_FIREBASE_PROJECT_ID"];
  
  var firestore = FirestoreApp.getFirestore(email, key, projectId);
  firestore.updateDocument("Characters/" + locale + "/" + document, json);
}
