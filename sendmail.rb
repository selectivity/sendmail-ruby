def  sendmail(toaddr, fromaddr, file2read, attach_as, subject, txt, sendmail="/usr/sbin/sendmail", _gzip="/bin/gzip", base64="/usr/bin/base64")
	gzip = _gzip + " -c -n"

	IO.popen(sendmail+" #{toaddr}","r+") do | pio |
	#open("./b.txt","w") do | pio |
		pio.print "From: #{fromaddr}\n";
		pio.print "To: #{toaddr}\n";
		pio.print "Subject: #{subject}\n";
		pio.print "Mime-Version: 1.0\n";
		pio.print "Content-Type: Multipart/Mixed; boundary=\"--Next_Part--\"\n";
		pio.print "Content-Transfer-Encoding: 7bit\n";
		pio.print "\n";
		pio.print "----Next_Part--\n";
		pio.print "Content-Type: Text/Plain; charset=iso-2022-jp\n";
		pio.print "Content-Transfer-Encoding: 7bit\n";
		pio.print "\n";
		pio.print txt
		pio.print "\n\n";
		pio.print "----Next_Part--\n";
		pio.print "Content-Type: application/gz; name=\"#{attach_as}\"\n";
		pio.print "Content-Transfer-Encoding: base64\n";
		pio.print "Content-Disposition: attachment; filename=\"#{attach_as}\"\n";
		pio.print "\n";
		IO.popen( "#{gzip} #{file2read} | #{base64}") do | base64 |
			while line=base64.gets do
				pio.print line
			end
		end
		pio.print "\n";
		pio.print "----Next_Part----\n";
		pio.print "\n";
	end
end
