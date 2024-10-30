package XML::LibXML::Reader::CfgAnalyser;

use 5.010;
#use parent XML::LibXML;
use parent 'XML::LibXML::Reader';
use Try::Tiny;

	use strict;
    use warnings;

    #sub new {
        #my $class = shift;
        #my %args = @_;    
    
		#my $self = {
			
			
		#};
    
        #bless $self, $class;
        #return $self;
    
    #}

sub get_unique_node_names_at_depth {
    my ($reader, $act_depth) = @_; # reader --self???
    my @unique_node_names;
say $reader;

    while ($reader->read) {
        if ($reader->nodeType < 8) {
            if ($reader->depth == $act_depth) {
                if (!grep { $_ eq $reader->name } @unique_node_names) {
                    push @unique_node_names, $reader->name;
                }
            }
        }
    }

    return @unique_node_names;
}

####

sub load_xml {

    my $self = shift;
    
say @_;
    try {
    $self->load_xml(@_);
	}
	catch {
        # Handle errors here
        warn "Error loading XML: $_";
        return;
    }
	return $self;
}

####

my $reader = XML::LibXML::Reader::CfgAnalyser->new(location => "/home/stefan/prog/bakki/cscrippy/cscrippy/config_offN1006.xml")
       or die "cannot read configfile\n";

say "###::#\n"; 
 my @taglist;
 
#@taglist = get_node_elements ($reader, 2);

1;

__END__

###
# https://metacpan.org/dist/XML-LibXML/view/lib/XML/LibXML/Reader.pod

use XML::LibXML::Reader;
 
 
 
my $reader = XML::LibXML::Reader->new(location => $script_metadata{configfile})
       or die "cannot read $script_metadata{configfile}\n";

say "###::#\n"; 
 my $prev;
 my %test;
 
 my @taglist;
 
@taglist = get_node_elements ($reader, 2);

say "22##:::#\n\n";
$reader = XML::LibXML::Reader->new(location => $script_metadata{configfile});
while ($reader->read) {
  processNode($reader);
# get_node_elements ($reader , "2");
}


 
sub get_node_elements { # get_nodeNamesByDepth
	my $reader = shift;
	my $act_depth = shift;
	my @new_list;
	

	while ($reader->read) {
	  if ($reader->nodeType < 8  ) {
		if ($reader->depth == $act_depth) {
			say $reader->name."---".$reader->nodeType;
if (	 join ('',@new_list) !~	$reader->name) {
	say "nu";
			push @new_list , $reader->name;
	}
		}
	  }
	}
	return @new_list;
}
 
sub processNode {
    my $reader = shift;
    
if ($reader->nodeType <8  ) {
    printf "%d %d %s %d\n", ($reader->depth,
                             $reader->nodeType,
                             $reader->name,
                   
                             $reader->isEmptyElement);
	
    if ($reader->hasValue) { 
		say $prev."--->".$reader->value ;
		$test{$prev} = $reader->value;
		
		
	} else { $prev=$reader->name;
	};
    #if ($reader->hasAttributes) { say "#".$reader->getAttribute ('date')}
    
   }
}
say "#####";
#print Dumper @taglist;
#print Dumper @all_taglist;

my @indicesToKeep = grep { $all_taglist[$_] !~ /^DEF/ } 0..$#all_taglist;
@all_taglist = @all_taglist[@indicesToKeep];

for my $j (0..$#all_taglist) {
	say $taglist[$j]."====".$all_taglist[$j];
}

###
