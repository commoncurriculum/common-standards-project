
GRADES = {
 "K" => "Kindergarten",
 "KG" => "Kindergarten",
 "1" => "Grade 1",
 "01" => "Grade 1",
 "2" => "Grade 2",
 "02" => "Grade 2",
 "3" => "Grade 3",
 "03" => "Grade 3",
 "4" => "Grade 4",
 "04" => "Grade 4",
 "5" => "Grade 5",
 "05" => "Grade 5",
 "6" => "Grade 6",
 "06" => "Grade 6",
 "7" => "Grade 7",
 "07" => "Grade 7",
 "8" => "Grade 8",
 "08" => "Grade 8",
 "09" => "Grade 9",
 "10" => "Grade 10",
 "11" => "Grade 11",
 "12" => "Grade 12",
 "HS" => "High School",
 "MP" => "K-12",
 ["KG", "01"] => "Kindergarten - Grade 1",
 ["KG", "01", "02"] => "Kindergarten - Grade 2",
 ["KG", "01", "02", "03"] => "Kindergarten - Grade 3",
 ["01", "02", "03", "04", "05"] => "Grades 1-5",
 ["03", "04", "05"] => "Grades 3-5",
 ["04", "05", "06", "07", "08", "09", "10", "11", "12"] => "Grades 4-12",
 ["06", "07", "08"] => "Grades 6-8",
 ["06", "07", "08", "09", "10", "11", "12"] => "Grades 6-12",
 ["09", "10", "11", "12"] => "Grades 9-12",
 ["09", "10"] => "Grades 9-10",
 ["11", "12"] => "Grades 11-12",
 ["KG", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"] => "K-12"
}


grades_to_grade_level = {
 "Kindergarten" => ["K"],
 "Grade 1" => ["01"],
 "Grade 2" => ["02"],
 "Grade 3" => ["03"],
 "Grade 4" => ["04"],
 "Grade 5" => ["05"],
 "Grade 6" => ["06"],
 "Grade 7" => ["07"],
 "Grade 8" => ["08"],
 "High School" => ["09", "10", "11", "12"],
 "K-12" => ["K", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
}



GRADE_LEVELS = {
"Infant/toddler"=>"IT",
"Preschool"=>"PR",
"Prekindergarten"=>"PK",
"Transitional Kindergarten"=>"TK",
"Kindergarten"=> "KG",
"First grade"=> "01",
"Second grade"=> "02",
"Third grade"=> "03",
"Fourth grade"=>"04",
"Fifth grade"=>"05",
"Sixth grade"=>"06",
"Seventh grade"=>"07",
"Eighth grade"=> "08",
"Ninth grade"=>"09",
"Tenth grade"=>"10",
"Eleventh grade"=> "11",
"Twelfth grade"=> "12",
"Grade 13"=>"13",
"Postsecondary"=>"PS",
"Adult education"=>"AE",
"Ungraded"=> "UG",
"Other"=>""
}

# Conversion of ASN to CEDS grade levels
ASN_TO_CEDS_LEVELS = {
"K"=> "KG",
"1"=> "01",
"2"=> "02",
"3"=> "03",
"4"=>"04",
"5"=>"05",
"6"=>"06",
"7"=>"07",
"8"=> "08",
"9" => "09",
"10" => "10",
"11" =>  "11",
"12"=> "12"
}


# lookup to convert to normal words
CC_GRADE_TO_WORDS = {
"K"=> "Kindergarten",
"1"=> "First Grade",
"2"=> "Second Grade",
"3"=> "Third Grade",
"4"=>"Fourth Grade",
"5"=>"Fifth Grade",
"6"=>"Sixth Grade",
"7"=>"Seventh Grade",
"8"=> "Eighth Grade",
"9" => "Ninth Grade",
"10" => "Tenth Grade",
"11" =>  "Eleventh Grade",
"12"=> "Twelfth Grade"
}

