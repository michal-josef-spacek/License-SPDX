package License::SPDX;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Cpanel::JSON::XS;
use File::Share ':all';
use List::Util qw(first);
use Perl6::Slurp qw(slurp);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Process parameters.
	set_params($self, @params);

	# Load all SPDX licenses.
	open my $data_fh, '<', dist_dir('License-SPDX').'/licenses.json';
	my $data = slurp($data_fh);
	$self->{'licenses'} = Cpanel::JSON::XS->new->ascii->pretty->allow_nonref->decode($data);

	return $self;
}

sub check_license {
	my ($self, $check_string, $opts_hr) = @_;

	if (! defined $opts_hr) {
		$opts_hr = {};
	}
	if (! exists $opts_hr->{'check_type'}) {
		$opts_hr->{'check_type'} = 'id';
	}

	my $check_cb = sub {
		my $license_hr = shift;
		if ($opts_hr->{'check_type'} eq 'id') {
			if ($check_string eq $license_hr->{'licenseId'}) {
				return 1;
			}
		}
	};

	if (first { $check_cb->($_); } @{$self->{'licenses'}->{'licenses'}}) {
		return 1;
	} else {
		return 0;
	}
}

sub license {
	my ($self, $license_id) = @_;

	return first { $_->{'licenseId'} eq $license_id } @{$self->{'licenses'}->{'licenses'}};
}

sub licenses {
	my $self = shift;

	return @{$self->{'licenses'}->{'licenses'}};
}

sub spdx_release_date {
	my $self = shift;

	return $self->{'licenses'}->{'releaseDate'};
}

sub spdx_version {
	my $self = shift;

	return $self->{'licenses'}->{'licenseListVersion'};
}

1;
