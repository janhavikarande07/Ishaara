String ip_address = "http://192.168.1.30:5000";

Map<String, dynamic> alphabets_map = {
  "1": ["A", "B", "C"], "2": ["B", "D", "E"], "3": ["C", "F", "G"], "4": ["A", "H", "I"], "5": ["D", "G", "J"],
  "6": ["F", "K", "L"], "7": ["E", "M", "N"], "8": ["L", "O", "P"], "9": ["M", "Q", "R"], "10": ["Q", "S", "T"],
  "11": ["H", "U", "V"], "12": ["K", "W", "X"], "13": ["P", "Y", "Z"],  "14": ["J", "B", "N"], "15": ["X", "D", "R"],
  "16": ["O", "L", "S"], "17": ["M", "E", "T"], "18": ["Q", "H", "U"], "19": ["V", "F", "G"], "20": ["A", "Y", "Z"],
  "21": ["I", "K", "P"], "22": ["N", "W", "X"], "23": ["O", "J", "T"], "24": ["R", "L", "Q"], "25": ["B", "S", "U"],
  "26": ["D", "M", "V"], "27": ["F", "K", "Y"], "28": ["H", "A", "X"], "29": ["G", "P", "Z"], "30": ["T", "O", "W"]
};

List<String> alphabets = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];

Map<String, dynamic> digits_map = {
  "1": ["1", "2"], "2": ["3", "4"], "3": ["5", "6"], "4": ["7", "8"], "5": ["9", "5"],
  "6": ["3", "7"], "7": ["1", "6"], "8": ["8", "2"], "9": ["9", "4"], "10": ["7", "1"],
  "11": ["5", "3"], "12": ["2", "6"], "13": ["9", "8"], "14": ["7", "6"], "15": ["1", "4"]
};

List<String> digits = [
  '1', '2', '3', '4', '5', '6', '7', '8', '9'
];

List<String> testing = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  '1', '2', '3', '4', '5', '6', '7', '8', '9'
];

dynamic current_learning_alphabets_level = 1;
dynamic current_learning_digits_level = 1;
dynamic current_testing_level = 1;

dynamic access_testing = false;

int daily_goal = 10;
int daily_streak = 0;
int xp = 0;
int lives = 5;
int day = 0;
int month = 0;

Map<dynamic, dynamic> learning_alphabets_levels = {
  "1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 0, "7": 0, "8": 0, "9": 0, "10": 0,
  "11": 0, "12": 0, "13": 0, "14": 0, "15": 0, "16": 0, "17": 0, "18": 0, "19": 0, "20": 0,
  "21": 0, "22": 0, "23": 0, "24": 0, "25": 0, "26": 0, "27": 0, "28": 0, "29": 0, "30": 0
};

Map<dynamic, dynamic> learning_digits_levels = {
  "1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 0, "7": 0, "8": 0, "9": 0, "10": 0,
  "11": 0, "12": 0, "13": 0, "14": 0, "15": 0
};

Map<dynamic, dynamic> testing_levels = {
  "1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 0, "7": 0, "8": 0, "9": 0, "10": 0,
  "11": 0, "12": 0, "13": 0, "14": 0, "15": 0, "16": 0, "17": 0, "18": 0, "19": 0, "20": 0,
  "21": 0, "22": 0, "23": 0, "24": 0, "25": 0, "26": 0, "27": 0, "28": 0, "29": 0, "30": 0
};

Map<String, dynamic> points_data = {
  "current_learning_digits_level" : current_learning_digits_level, "current_learning_alphabets_level" : current_learning_alphabets_level,
  "learning_digits_levels" : learning_digits_levels, "learning_alphabets_levels" : learning_alphabets_levels, "testing_levels": testing_levels,
  "current_testing_level" : current_testing_level, "access_testing" : access_testing, "lives": lives, "xp": xp
};