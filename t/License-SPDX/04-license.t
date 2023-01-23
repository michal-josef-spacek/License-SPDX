use strict;
use warnings;

use License::SPDX;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = License::SPDX->new;
my $ret_hr = $obj->license('MIT');
is_deeply(
	$ret_hr,
	{
		'detailsUrl' => 'https://spdx.org/licenses/MIT.json',
		'isDeprecatedLicenseId' => 0,
		'isFsfLibre' => 1,
		'isOsiApproved' => 1,
		'licenseId' => 'MIT',
		'name' => 'MIT License',
		'reference' => 'https://spdx.org/licenses/MIT.html',
		'referenceNumber' => 141,
		'seeAlso' => [
			'https://opensource.org/licenses/MIT',
		],
	},
	'Look for MIT license.',
);
