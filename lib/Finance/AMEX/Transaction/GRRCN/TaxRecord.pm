package Finance::AMEX::Transaction::GRRCN::TaxRecord;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Global Reconciliation (GRRCN) TaxRecord Rows

use base 'Finance::AMEX::Transaction::GRRCN::Base';

sub field_map {
  return {
    RECORD_TYPE                     => [1, 10],
    PAYEE_MERCHANT_ID               => [11, 15],
    SETTLEMENT_ACCOUNT_TYPE_CODE    => [26, 3],
    AMERICAN_EXPRESS_PAYMENT_NUMBER => [29, 10],
    PAYMENT_DATE                    => [39, 8],
    PAYMENT_CURRENCY                => [47, 3],

    TAX_TYPE_CODE                   => [50, 2],
    TAX_DESCRIPTION                 => [52, 64],
    TAX_BASE_AMOUNT                 => [116, 24],
    TAX_PRESENT_DATE                => [140, 8],
    TAX_RATE                        => [148, 20],
    TAX_AMOUNT                      => [168, 24],
  };
}

sub type {return 'TAXRECORD'}

sub RECORD_TYPE                     {return $_[0]->_get_column('RECORD_TYPE')}
sub PAYEE_MERCHANT_ID               {return $_[0]->_get_column('PAYEE_MERCHANT_ID')}
sub SETTLEMENT_ACCOUNT_TYPE_CODE    {return $_[0]->_get_column('SETTLEMENT_ACCOUNT_TYPE_CODE')}
sub AMERICAN_EXPRESS_PAYMENT_NUMBER {return $_[0]->_get_column('AMERICAN_EXPRESS_PAYMENT_NUMBER')}
sub PAYMENT_DATE                    {return $_[0]->_get_column('PAYMENT_DATE')}
sub PAYMENT_CURRENCY                {return $_[0]->_get_column('PAYMENT_CURRENCY')}
sub TAX_TYPE_CODE                   {return $_[0]->_get_column('TAX_TYPE_CODE')}
sub TAX_DESCRIPTION                 {return $_[0]->_get_column('TAX_DESCRIPTION')}
sub TAX_BASE_AMOUNT                 {return $_[0]->_get_column('TAX_BASE_AMOUNT')}
sub TAX_PRESENT_DATE                {return $_[0]->_get_column('TAX_PRESENT_DATE')}
sub TAX_RATE                        {return $_[0]->_get_column('TAX_RATE')}
sub TAX_AMOUNT                      {return $_[0]->_get_column('TAX_AMOUNT')}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::GRRCN::TaxRecord - Object methods for AMEX Global Reconciliation (GRRCN) Tax records.

Note: This record is only applicable for Argentina.

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'GRRCN');
 open my $fh, '<', '/path to GRRCN file' or die "cannot open GRRCN file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'SUMMARY') {
    print $record->PAYMENT_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an GRRCN  file');
 if ($record->type eq 'SUMMARY') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new L<Finance::AMEX::Transaction::GRRCN::TaxRecord> object.

 my $record = Finance::AMEX::Transaction::GRRCN::TaxRecord->new(line => $line);

=method type

This will always return the string SUMMARY.

 print $record->type; # SUMMARY

=method line

Returns the full line that is represented by this object.

 print $record->line;

=method RECORD_TYPE

This field contains the Record identifier, which will always be “TAXRECORD” for the Tax Record(s).

Note: This record is only applicable to the Argentina market.

=method PAYEE_MERCHANT_ID

This field contains the American Express-assigned Service Establishment (SE) Number of the Merchant receiving the payment/settlement.

=method SETTLEMENT_ACCOUNT_TYPE_CODE

This field contains the Settlement Account Type.

Valid values include the following:

=for :list
= 002 = Primary
= 001 = Discount
= 004 = All Chargebacks

If unused, this field will be space filled (fixed format) or blank (delimited formats).

=method AMERICAN_EXPRESS_PAYMENT_NUMBER

This field contains the American Express-assigned Payment/Settlement Number. This reference number may be used by the American Express Payee for reconciliation purposes.

=method PAYMENT_DATE

This field contains the Payment Date scheduled in American Express systems. The date that funds are actually available to the payee's depository institution may differ from the date reported in this field.

The format is: YYYYMMDD

=for :list
= YYYY = Year
= MM   = Month
= DD   = Day

=method PAYMENT_CURRENCY

This field contains the Alphanumeric ISO Code for the Payment (Settlement) currency.

=method TAX_TYPE_CODE

This field contains a numerical value between 01 and 99 according to the description of tax.

=method TAX_DESCRIPTION

This field contains a description of the tax applied, which corresponds to the Tax Type Code field.

Note: there may be multiple descriptions for a single tax code.

=method TAX_BASE_AMOUNT

This field contains the amount on which tax is applied.

The format of the Tax Base Amount field value is: leading sign (1), whole numbers (13) and decimal places (10).

=method TAX_PRESENT_DATE

This field contains the date when American Express pays the tax to the tax collector.

The format is: YYYYMMDD

=for: list
= YYYY = Year
=   MM = Month
=   DD = Day

=method TAX_RATE

This field contains the Tax Rate Percentage, which corresponds to the calculation of the tax Amount.

This field is expressed as an actual percentage. The format of the Tax Rate field value is: leading sign (1), whole numbers (13)
and decimal places (6). Right aligned with leading zeros.

For example:
 Rate            Displayed in File
 +21%            ~0000000000021000000
 +21.123446%     ~0000000000021123446
  -5.05%         -0000000000005050000

=method TAX_AMOUNT

This field contains the amount of the tax.

The Tax Amount is calculated as follows;

Tax Base Amount * Tax Rate = Tax Amount.

“Tax Rate” used in above calculation is a decimal value (i.e., Tax Base Amount = 1000, Tax Rate = 20%, Tax Amount = 200; 1000 * 0.2 = 200).

The format of the Tax Amount field value is: leading sign (1), whole numbers (13) and decimal places (10).
