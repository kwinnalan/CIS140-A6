## Assignment: 6 part A
## Version: 01
## Author: Kwinn Danforth (kdanforth@student.ncmcih.edu)
## Purpose: This assignment askes to write a perl program that prompts a user to enter new patient data for an emergency room.

use 5.14.2;
use warnings;

my ($welcome, $continue, $counter, $menuChoice);
my (@patients, @homeMenu);
my ($day, $month, $year) = (localtime)[3,4,5];

use constant COLUMBS => 8;
use constant TRUE => 1;

sub main {
	system ("clear");
    setDate();
    setWelcome();
    setHomeMenu();
    displayWelcome();
    displayHomeMenu();
    getUserMenuChoice();
    processMenuChoice();

}

main();

sub setDate {
if(defined $counter){
}else{
    $day = $day;
    $month = $month+1;
    $year = $year+1900;
    }
}

sub setWelcome {
    $welcome = "$month/$day/$year\n Welcome, below are your menu options:";
}

sub setHomeMenu {
    @homeMenu = ('Add a patient', 'Process Patients');  
}

sub displayWelcome {
    print "$welcome\n";
}

sub displayHomeMenu {
my $i = 1;
    foreach(@homeMenu){
      print("$i.", " $_", "\n");
      $i++;
    }
}

sub getUserMenuChoice {
		$menuChoice = -1;
		while ($menuChoice !~ /[0-9]/ || $menuChoice > ($#homeMenu+1) || $menuChoice < 1) {
			print "\nPlease Enter a selection from the menu: ";
			chomp ($menuChoice = <STDIN>);
			if ($menuChoice !~ /[0-9]/ || $menuChoice > ($#homeMenu+1) || $menuChoice < 1) {
				say "Incorrect input. Please try again";
				sleep 1;
				system ("clear");
                displayHomeMenu();
        }
    }
}


sub processMenuChoice {
    if ($menuChoice == 1) {
        setContinue();
        addPatient();
    } else{
        processPatientData();  
    }

}

sub addPatient {
	setCounter();
    setPatientID();
	setLastName();
	setFirstName();
    setMiddleName();
    setDOB();
    setInsuranceCarrier();
    setAilment();
	setContinue();
	if ($continue == TRUE) {
		addPatient();
    } else {
        main();
    }
}

sub processPatientData {        
my $dailyReportFile = "dailyReport$month-$day-$year.txt";
open(my $dayReportFileHandle, '>>', $dailyReportFile) or die "could not open file '$dailyReportFile' $!";

        for (my $i = 1; $i <= $#patients; $i++){
               for (my $j = 0; $j < (&COLUMBS); $j++){
                     if($j != (&COLUMBS-1)){
                         print $dayReportFileHandle "$patients[$i][$j], ";
                     }else{
                         print $dayReportFileHandle "$patients[$i][$j]\n";
                     }
                } 
              }              
close $dayReportFileHandle;
processNoInsurance();
}

sub processNoInsurance{
my $dailyNoInsuranceFile = "dailyNoInsurence$month-$day-$year.txt";
open(my $noInsuranceFileHandle, '>>', $dailyNoInsuranceFile) or die "could not open file '$dailyNoInsuranceFile' $!";
    for (my $i = 1; $i <= $#patients; $i++){
          for (my $j = 0; $j < (&COLUMBS); $j++){
                if($j == &COLUMBS-2 && $patients[$i][$j] eq 'none'){
                      for (my $k = 0; $k < &COLUMBS; $k++){
                                        if($k != &COLUMBS-1){
                                           print $noInsuranceFileHandle "$patients[$i][$k], ";
                                        }else{
                                             print $noInsuranceFileHandle "$patients[$i][$k]\n";
                                        
                                        }
                                }
                        }
                }
        }
              close $noInsuranceFileHandle;
}

sub setCounter {
	if (defined $counter) {
		$counter++;
	} else {
		$counter = 1;
	}
}

sub setContinue {
     if (defined $continue) {
		$continue = -1;
		while ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
			print "\n\nDo you want to add another patient? (0=no, 1=yes)? ";
			chomp ($continue = <STDIN>);
			if ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
				say "Incorrect input. Please try again";
				sleep 1;
				system ("clear");
			}
		}
     } else {
          $continue = 1;
     }
}

sub setPatientID {
my $patientID = ($counter + 1000);
$patients[$counter][(&COLUMBS - &COLUMBS)] = $patientID;
}

sub setLastName {
my $lastName;
	if (!(defined $lastName)) {
		$lastName = 1;
	}
	while ($lastName !~ /^[a-zA-Z]{2,20}$/x) {
		print "What is the patients last name? ";
		chomp ($lastName = <STDIN>);
		if ($lastName !~ /^[a-zA-Z]{2,20}$/x) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("clear");
		}else {
            $patients[$counter][&COLUMBS-&COLUMBS+1] = $lastName;
        }
	}
}

sub setFirstName {
my $firstName;
	if (!(defined $firstName)) {
		$firstName = 1;
	}
	while ($firstName !~ /^[a-zA-Z]{2,20}$/x) {
		print "What is the patients first name? ";
		chomp ($firstName = <STDIN>);
		if ($firstName !~ /^[a-zA-Z]{2,20}$/x) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("cls");
		}else {
            $patients[$counter][&COLUMBS-&COLUMBS+2] = $firstName;
        }
	}
}

sub setMiddleName {
my $middleName;
	if (!(defined $middleName)) {
		$middleName = 1;
	}
	while ($middleName !~ /^[a-zA-Z]{2,20}$/x) {
		print "What is the patients middle name? ";
		chomp ($middleName = <STDIN>);
		if ($middleName !~ /^[a-zA-Z]{2,20}$/x) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("clear");
		}else {
            $patients[$counter][&COLUMBS-&COLUMBS+3] = $middleName;
        }
	}
}

sub setDOB {
my $birthMonth = setBirthMonth();
my $birthDay = setBirthDay();
my $birthYear = setBirthYear();
my $DOB = "$birthMonth/$birthDay/$birthYear";
$patients[$counter][&COLUMBS-&COLUMBS+4] = $DOB;
calculateAge($birthMonth, $birthDay, $birthYear);
}

sub calculateAge {
my ($birthMonth, $birthDay, $birthYear) = @_;
my $age = $year-$birthYear;
if($birthMonth > $month){
    $age = $age-1;
}elsif($birthMonth == $month && $birthDay > $day){
    $age = $age-1;
}
$patients[$counter][&COLUMBS-&COLUMBS+5] = $age;
}

sub setBirthMonth {
my $birthMonth;
	if (!(defined $birthMonth)) {
		$birthMonth = 0;
	}
	while ($birthMonth < 1 || $birthMonth > 12) {
		print "What is the patients birth month? ";
		chomp ($birthMonth = <STDIN>);
		if ($birthMonth < 1 || $birthMonth > 12) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("clear");
		}else {
            return $birthMonth;
        }
	}
}

sub setBirthDay {
my $birthDay;
	if (!(defined $birthDay)) {
		$birthDay = 0;
	}
	while ($birthDay < 1 || $birthDay > 31) {
		print "What is the patients birth day? ";
		chomp ($birthDay = <STDIN>);
		if ($birthDay < 1 || $birthDay > 31) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("clear");
		}else {
            return $birthDay;
        }
	}
}

sub setBirthYear {
my $birthYear;
	if (!(defined $birthYear)) {
		$birthYear = 0;
	}
	while ($birthYear < 1900 || $birthYear > 2021) {
		print "What is the patients birth year? ";
		chomp ($birthYear = <STDIN>);
		if ($birthYear < 1900 || $birthYear > 2021) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("clear");
		}else {
            return $birthYear;
        }
	}
}

sub setInsuranceCarrier {
my $insuranceCarrier;
	if (!(defined $insuranceCarrier)) {
		$insuranceCarrier = 1;
	}
	while ($insuranceCarrier !~ /^[a-zA-Z]{2,20}$/x) {
		print "What is the patients insurance carrier?(if uninsured type 'none') ";
		chomp ($insuranceCarrier = <STDIN>);
		if ($insuranceCarrier !~ /^[a-zA-Z]{2,20}$/x) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("clear");
		}else {
            $patients[$counter][&COLUMBS-&COLUMBS+6] = $insuranceCarrier;
        }
	}
}

sub setAilment {
my $ailment;
	if (!(defined $ailment)) {
		$ailment = 1;
	}
	while ($ailment !~ /^[a-zA-Z]{2,20}$/x) {
		print "What is the patients ailment? ";
		chomp ($ailment = <STDIN>);
		if ($ailment !~ /^[a-zA-Z]{2,20}$/x) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("clear");
		}else {
            $patients[$counter][&COLUMBS-&COLUMBS+7] = $ailment;
        }
	}
}
