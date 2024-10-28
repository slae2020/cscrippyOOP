use strict;
use warnings;
use Test::More;
use lib "/home/stefan/prog/bakki/cscrippy/";
use Uupm::Dialog;

BEGIN {
    # Enable test mode for the dialog
    $Uupm::Dialog::is_test_mode = 0;
}

# Test set_dialog_item()
sub test_set_dialog_item {
    my $field_name = 'titles';
    my @new_items = ('New Title', 'New Text', ' ');

    # Test valid item setting
    set_dialog_item($field_name, @new_items);
    is_deeply($Uupm::Dialog::dialog_config{$field_name}, \@new_items, "Correctly set dialog item");

    # Test invalid field name
    eval { set_dialog_item('invalid_field', 'Test'); };
    like($@, qr/Unknown or useless field-name/, "Invalid field name throws an error");

    # Test incorrect number of arguments
    eval { set_dialog_item($field_name, 'Only one argument'); };
    like($@, qr/Error: set-dialog-item for '$field_name' expects 4 arguments/, "Incorrect arg count throws an error");
}

# Test add_list_item()
sub test_add_list_item {
    my ($flag, $id, $text) = (1, '01', 'First Item');
    my @result = add_list_item($flag, $id, $text);
    
    is_deeply(\@result, [$id, [$text, $flag]], "List item added correctly");

    # Test for list_id length exceeding limit
    eval { add_list_item(1, '123456', 'Too Long Item'); };
    like($@, qr/Error: list_id '123456' length exceeds 5 characters/, "Too long list_id throws an error");

    # Test for invalid checkbox flag
    my @invalid_result = add_list_item('invalid', '02', 'Second Item');
    is_deeply(\@invalid_result, ['02', ['Second Item', 0]], "Invalid checkbox flag defaults to 0");
}

# Test message_exit()
sub test_message_exit {
    eval { message_exit("Simulated error", 42); };
    like($@, qr/Leaving program with code 42/, "message_exit handles errors correctly");
}

# Test message_notification()
sub test_message_notification {
    # Simulate no zenity installed by setting command to an invalid path
    local $ENV{PATH} = "/invalid/path";
    message_notification("Test notification", 5);
    # Check if the warning was printed (would need to capture STDERR for this)
}

# Test ask_to_continue()
sub test_ask_to_continue {
    my $result = ask_to_continue("Continue?", 0);
    is($result, 1, "ask_to_continue returns 1 in test mode");
}

# Test ask_to_choose()
sub test_ask_to_choose {
    # Prepare list for selection
    @{$Uupm::Dialog::dialog_config{list}} = (add_list_item(1, '01', 'Item 1'), add_list_item(0, '02', 'Item 2'));

    my @result = ask_to_choose("Choose an item", 0);

    is_deeply(\@result, ['01'], "ask_to_choose returns correct selected item in test mode");
}

# Execute tests
test_set_dialog_item();
test_add_list_item();
#test_message_exit();
#test_message_notification();
#test_ask_to_continue();
#test_ask_to_choose();

done_testing();
