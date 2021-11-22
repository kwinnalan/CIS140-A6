## Assignment: Week Eleven
## Version: 12.01.2011.01
## Author: Howard Bates (hbates@northmen.org)
## Purpose: To demonstrate hashes, regular expressions, given/when, random, int, recursion

use 5.14.2;
use warnings;

my ($lastName, $firstName);
my ($age, $printSelection, $langChoice, $continue, $counter);
my %languagePreference;
use constant MAX_RECURSION => 5;
use constant TRUE => 1;

sub main {
	system ("cls");
	setContinue();
	setCounter();
	setLanguagePreferenceHash();
	setLastName();
	setFirstName();
	setAge();
	setPrintSelection();
	setLanguagePreference();
	printSelections();
	printLanguagePreference();
	printRandomness();
	setContinue();
	if ($continue == TRUE && $counter > MAX_RECURSION) {
		main();
	}
}

main();

sub setCounter {
	if (defined $counter) {
		$counter++;
	} else {
		$counter = 0;
	}
}

sub setContinue {
     if (defined $continue) {
		$continue = -1;
		while ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
			print "\n\nDo you want to continue (0=no, 1=yes)? ";
			chomp ($continue = <STDIN>);
			if ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
				say "Incorrect input. Please try again";
				sleep 1;
				system ("cls");
			}
		}
     } else {
          $continue = 1;
     }
}

sub setLanguagePreferenceHash {
	%languagePreference = (
		P => 'Perl',
		C => 'C',
		V => 'Visual Basic',
		J => 'Java',
		R => 'Ruby',
		H => 'PHP',
		Y => 'Python',
	);
	$languagePreference{L} = 'Lua';
}

sub setLastName {
	if (!(defined $lastName)) {
		$lastName = 1;
	}
	while ($lastName !~ /^[a-zA-Z]{2,20}$/x) {
		print "What is your last name? ";
		chomp ($lastName = <STDIN>);
		if ($lastName !~ /^[a-zA-Z]{2,20}$/x) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("cls");
		}
	}
}

sub setFirstName {
	if (!(defined $firstName)) {
		$firstName = 1;
	}
	while ($firstName !~ /^[a-zA-Z]{2,20}$/x) {
		print "What is your first name? ";
		chomp ($firstName = <STDIN>);
		if ($firstName !~ /^[a-zA-Z]{2,20}$/x) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("cls");
		}
	}
}

sub setAge {
	use constant MAX_AGE => 130;
	if (!(defined $age)) {
		$age = 0;
	}
	while ($age !~ /[0-9]/x || $age > MAX_AGE || $age <= 0) {
		print "What is your age? ";
		chomp ($age = <STDIN>);
		if ($age !~ /[0-9]/x || $age > MAX_AGE || $age <= 0) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("cls");
		}
	}
}

sub setPrintSelection {
	use constant MAX_CHOICE => 7;
	if (! defined $printSelection) {
		$printSelection = 0;
	}
	while ($printSelection !~ /[0-9]/x || $printSelection > MAX_CHOICE || $printSelection <= 0) {
		print "\n\n";
		print "What would you like to print?\n";
		print "1 = Last Name\n";
		print "2 = First Name\n";
		print "4 = Age\n";
		print "Or math combo for multiple, i.e. 3=last & first, 5=last & age, etc.\n\n";
		print "Choose: ";
		chomp ($printSelection = <STDIN>);
		if ($printSelection !~ /[0-9]/x || $printSelection > MAX_CHOICE || $printSelection <= 0) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("cls");
		}
	}
}

sub setLanguagePreference {
	use constant MAX_CHOICE => 4;
	if (! defined $langChoice) {
		$langChoice = 0;
	}
	while ($langChoice !~ /[0-9]/x || $langChoice > MAX_CHOICE || $langChoice <= 0) {
		print "\n\n";
		print "What is your programming language preference?\n";
		print "1 = Perl\n";
		print "2 = C\n";
		print "3 = VB\n";
		print "4 = Java\n";
		print "Choose: ";
		chomp ($langChoice = <STDIN>);
		print "\n";
		if ($langChoice !~ /[0-9]/x || $langChoice > MAX_CHOICE || $langChoice <= 0) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("cls");
		}
	}
}

sub printSelections {
	given ($printSelection) {
		when (1) {print "$lastName\n"}
		when (2) {print "$firstName\n"}
		when (4) {print "$age\n"}
		when (3) {print "$lastName, $firstName\n"}
		when (5) {print "$lastName, $age\n"}
		when (6) {print "$firstName, $age\n"}
		when (7) {print "$lastName, $firstName, $age\n"}
		default {warn "ERROR! 1-7 only.\n"; main()}
	}
}

sub printLanguagePreference {
	print "\n";
	given ($langChoice) {
		when (1) {print "\nYour language preference is: $languagePreference{P} \n"}
		when (2) {print "\nYour language preference is: $languagePreference{C} \n"}
		when (3) {print "\nYour language preference is: $languagePreference{V} \n"}
		when (4) {print "\nYour language preference is: $languagePreference{J} \n"}
		default {print "WRONG! 1-4 only.\n"; main()}
	}
	print "\nAll language choices were: \n";
	foreach (keys %languagePreference) {
		print "The key $_ contains $languagePreference{$_}";
		print "\n";
	}
}

sub printRandomness {
	my $random = int(rand $age);
	print "\n\nYour random number is: $random \n\n\n";
}
