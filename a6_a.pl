## Assignment: 6 part A
## Version: 01
## Author: Kwinn Danforth (kdanforth@student.ncmcih.edu)
## Purpose: This assignment askes to write a perl program that prompts a user to enter new patient data for an emergency room.

use 5.14.2;
use warnings;

my ($welcome, $continue, $counter, $menuChoice);
my (@patient, @patients, @homeMenu);
use constant MAX_RECURSION => 5;
use constant TRUE => 1;

sub main {
	system ("clear");
    setWelcome();
    setHomeMenu();
    displayWelcome();
    displayHomeMenu();
    getUserMenuChoice();
    processMenuChoice();

}

main();

sub setWelcome {
    $welcome = "Welcome, below are your menu options:";
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
my ( $dob, $insuranceCarrier, $Ailment);
	setCounter();
    setPatientID();
	setLastName();
	setFirstName();
    setMiddleName();
    push(@patients, (@patient));
	setContinue();
	if ($continue == TRUE) {
		addPatient();
    } else {
        main();
    }
}

sub processPatientData {
        #for my $i (@patients){
my @patientOne = $patients[0];
#my @patientOne = $patients[$i];
# for (my $j = 0; $j <= $#patientOne; $j++){
            my $ID = $patientOne[0];
            print "$ID";
        }
        #}
        #}

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
@patient = $patientID;
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
            push(@patient, ($lastName));
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
            push(@patient, ($firstName));
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
            push(@patient, ($middleName));
        }
	}
}

