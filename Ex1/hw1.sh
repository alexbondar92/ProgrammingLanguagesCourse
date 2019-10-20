# anastasia neiman 313103400 anastasiane@campus.technion.ac.il #
# alex bondar      311822258 alex.bondar@campus.technion.ac.il #

cat courses.html | grep -w course_type_project | grep -v "<td align=center bgcolor=#EDEDED>&nbsp;</td>" | grep -oE  "<tr class=\'course_type_project.+\bProject" | grep -oE "\d{6}.+(<\/td><td>)" | sed -e 's/<\/td><td>//g'