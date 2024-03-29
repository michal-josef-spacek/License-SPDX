use strict;
use warnings;

use JSON::PP::Boolean;
use License::SPDX;
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Booleans.
my $true = do { bless \(my $dummy = 1), "JSON::PP::Boolean" };
my $false = do { bless \(my $dummy = 0), "JSON::PP::Boolean" };

# Test.
my $obj = License::SPDX->new;
my $ret_hr = $obj->license('MIT');
is_deeply(
	$ret_hr,
	{
		'detailsUrl' => 'https://spdx.org/licenses/MIT.json',
		'isDeprecatedLicenseId' => $false,
		'isFsfLibre' => $true,
		'isOsiApproved' => $true,
		'licenseId' => 'MIT',
		'name' => 'MIT License',
		'reference' => 'https://spdx.org/licenses/MIT.html',
		'referenceNumber' => 223,
		'seeAlso' => [
			'https://opensource.org/licenses/MIT',
		],
	},
	'Look for MIT license.',
);

# Test.
$obj = License::SPDX->new;
$ret_hr = $obj->license('BAD');
is_deeply(
	$ret_hr,
	undef,
	'Look for BAD license.',
);
