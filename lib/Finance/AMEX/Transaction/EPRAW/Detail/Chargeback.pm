package Finance::AMEX::Transaction::EPRAW::Detail::Chargeback;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Reconciliation Files (EPRAW) Chargeback Detail Rows

use base 'Finance::AMEX::Transaction::EPRAW::Base';

sub field_map {
  return {
    AMEX_PAYEE_NUMBER         => [1,   10],
    AMEX_SE_NUMBER            => [11,  10],
    SE_UNIT_NUMBER            => [21,  10],
    PAYMENT_YEAR              => [31,  4],
    PAYMENT_NUMBER            => [35,  8],
    PAYMENT_NUMBER_DATE       => [35,  3],
    PAYMENT_NUMBER_TYPE       => [38,  1],
    PAYMENT_NUMBER_NUMBER     => [39,  4],
    RECORD_TYPE               => [43,  1],
    DETAIL_RECORD_TYPE        => [44,  2],
    SE_BUSINESS_DATE          => [46,  7],
    AMEX_PROCESS_DATE         => [53,  7],
    SOC_INVOICE_NUMBER        => [60,  6],
    SOC_AMOUNT                => [66,  11],
    CHARGEBACK_AMOUNT         => [77,  9],
    DISCOUNT_AMOUNT           => [86,  9],
    SERVICE_FEE_AMOUNT        => [95,  7],
    NET_CHARGEBACK_AMOUNT     => [109, 9],
    DISCOUNT_RATE             => [118, 5],
    SERVICE_FEE_RATE          => [123, 5],
    CHARGEBACK_REASON         => [144, 280],
    SERVICE_AGENT_MERCHANT_ID => [430, 15],
  };
}

sub type {return 'CHARGEBACK_DETAIL'}

sub AMEX_PAYEE_NUMBER         {return $_[0]->_get_column('AMEX_PAYEE_NUMBER')}
sub AMEX_SE_NUMBER            {return $_[0]->_get_column('AMEX_SE_NUMBER')}
sub SE_UNIT_NUMBER            {return $_[0]->_get_column('SE_UNIT_NUMBER')}
sub PAYMENT_YEAR              {return $_[0]->_get_column('PAYMENT_YEAR')}
sub PAYMENT_NUMBER            {return $_[0]->_get_column('PAYMENT_NUMBER')}
sub PAYMENT_NUMBER_DATE       {return $_[0]->_get_column('PAYMENT_NUMBER_DATE')}
sub PAYMENT_NUMBER_TYPE       {return $_[0]->_get_column('PAYMENT_NUMBER_TYPE')}
sub PAYMENT_NUMBER_NUMBER     {return $_[0]->_get_column('PAYMENT_NUMBER_NUMBER')}
sub RECORD_TYPE               {return $_[0]->_get_column('RECORD_TYPE')}
sub DETAIL_RECORD_TYPE        {return $_[0]->_get_column('DETAIL_RECORD_TYPE')}
sub SE_BUSINESS_DATE          {return $_[0]->_get_column('SE_BUSINESS_DATE')}
sub AMEX_PROCESS_DATE         {return $_[0]->_get_column('AMEX_PROCESS_DATE')}
sub SOC_INVOICE_NUMBER        {return $_[0]->_get_column('SOC_INVOICE_NUMBER')}
sub SOC_AMOUNT                {return $_[0]->_get_column('SOC_AMOUNT')}
sub CHARGEBACK_AMOUNT         {return $_[0]->_get_column('CHARGEBACK_AMOUNT')}
sub DISCOUNT_AMOUNT           {return $_[0]->_get_column('DISCOUNT_AMOUNT')}
sub SERVICE_FEE_AMOUNT        {return $_[0]->_get_column('SERVICE_FEE_AMOUNT')}
sub NET_CHARGEBACK_AMOUNT     {return $_[0]->_get_column('NET_CHARGEBACK_AMOUNT')}
sub DISCOUNT_RATE             {return $_[0]->_get_column('DISCOUNT_RATE')}
sub SERVICE_FEE_RATE          {return $_[0]->_get_column('SERVICE_FEE_RATE')}
sub CHARGEBACK_REASON         {return $_[0]->_get_column('CHARGEBACK_REASON')}
sub SERVICE_AGENT_MERCHANT_ID {return $_[0]->_get_column('SERVICE_AGENT_MERCHANT_ID')}
1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::EPRAW::Detail::Chargeback - Object methods for AMEX Reconciliation file chargeback detail records.

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'EPRAW');
 open my $fh, '<', '/path to EPRAW file' or die "cannot open EPRAW file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'CHARGEBACK_DETAIL') {
    print $record->AMEX_PROCESS_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an EPRAW  file');
 if ($record->type eq 'CHARGEBACK_DETAIL') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new L<Finance::AMEX::Transaction::EPRAW::Detail::Chargeback> object.

 my $record = Finance::AMEX::Transaction::EPRAW::Detail::Chargeback->new(line => $line);

=method type

This will always return the string CHARGEBACK_DETAIL.

 print $record->type; # CHARGEBACK_DETAIL

=method line

Returns the full line that is represented by this object.

 print $record->line;

=method field_map

Returns an arrayref of hashrefs where the name is the record name and 
the value is an arrayref of the start position and length of that field.

 # print the start position of the PAYMENT_DATE field
 print $record->field_map->[3]->{PAYMENT_DATE}->[0]; # 31

=method AMEX_PAYEE_NUMBER

This field contains the Service Establishment (SE) Number of the merchant that received the payment from American Express.

Note: SE Numbers are assigned by American Express.

=method AMEX_SE_NUMBER

This field contains the Service Establishment (SE) Number of the merchant being reconciled, which may not necessarily be the same SE receiving payment (see AMEX_PAYEE_NUMBER).

This is the SE Number under which the transactions were submitted, which usually corresponds to the physical location.

=method SE_UNIT_NUMBER

This field contains the merchant-assigned SE Unit Number (usually an internal, store identifier code) that corresponds to a specific store or location.

If no value is assigned, this field is character space filled.

=method PAYMENT_YEAR

This field contains the Payment Year that corresponds to the entry in the Julian Date subfield of PAYMENT_NUMBER.

=method PAYMENT_NUMBER

This field contains the Payment Number, a reference number used by the American Express Payee to reconcile the daily settlement to the daily payment.

=method PAYMENT_NUMBER_DATE

The Julian date of the payment.

=method PAYMENT_NUMBER_TYPE

An alpha character assigned by the American Express settlement system.

=method PAYMENT_NUMBER_NUMBER

The Number of the payment.

=method RECORD_TYPE

This field contains the constant literal “2”, a Record Type code that indicates that this is a Detail Record.

=method DETAIL_RECORD_TYPE

This field contains the Detail Record Type code that indicates the type of record used in this transaction. For Chargeback Detail Records, this entry is always “20”.

=method SE_BUSINESS_DATE

This field contains the SE Business Date assigned to this submission by the submitting merchant location.

The format is: YYYYDDD

=for :list
= YYYY = Year
= DDD = Julian Date

=method AMEX_PROCESS_DATE

This field contains the American Express Transaction Processing Date, which is used to determine the payment date.

The format is: YYYYDDD

=for :list
= YYYY = Year
= DDD = Julian Date

=method SOC_INVOICE_NUMBER

This field contains the Summary of Charge (SOC) Invoice Number.

=method SOC_AMOUNT

This field contains the Summary of Charge (SOC) Amount originally submitted for payment.

Note: For US Dollar (USD) and Canadian Dollar (CAD) transactions, two decimal places are implied.

A debit amount (positive) is indicated by an upper-case alpha code used in place of the last digit in the amount.

The debit codes and their numeric equivalents are listed below:

=for :list
= 1=A
= 2=B
= 3=C
= 4=D
= 5=E
= 6=F
= 7=G
= 8=H
= 9=I
= 0={

A credit amount (negative) is also indicated by an upper-case alpha code used in place of the last digit in the amount.

The credit codes and their numeric equivalents are listed below:

=for :list
= 1=J
= 2=K
= 3=L
= 4=M
= 5=N
= 6=O
= 7=P
= 8=Q
= 9=R
= 0=}

The following are examples of how amounts would appear:

 Amount     Debit         Credit
   $1.11    0000000011A   0000000011J
 $345.05    0000003450E   0000003450N
  $22.70    0000000227{   0000000227}

=method CHARGEBACK_AMOUNT

This field contains the Chargeback Amount, which is the gross amount charged back to the merchant against the original SOC_INVOICE_NUMBER and SOC_AMOUNT.

=method DISCOUNT_AMOUNT

This field contains the total Discount Amount, based on CHARGEBACK_AMOUNT, and DISCOUNT_RATE.

=method SERVICE_FEE_AMOUNT

This field contains the total Service Fee Amount, based on CHARGEBACK_AMOUNT, and SERVICE_FEE_RATE.

=method NET_CHARGEBACK_AMOUNT

This field contains the Net Amount of the Chargeback, which is the sum total of CHARGEBACK_AMOUNT, less DISCOUNT_AMOUNT and SERVICE_FEE_AMOUNT.

=method DISCOUNT_RATE

This field contains the Discount Rate (decimal place value) used to calculate the amount American Express charges a merchant for services provided per the American Express Card Acceptance Agreement.

=method SERVICE_FEE_RATE

This field contains the Service Fee Rate (decimal place value) used to calculate the amount American Express charges a merchant as service fees.

Service fees are assessed only in certain situations and may not apply to all SEs.

=method CHARGEBACK_REASON

This field contains the Chargeback Reason, which is the reason the Merchant is assessed the amount that appears in CHARGEBACK_AMOUNT.

A list of reason descriptions can be found below.

=for :list
= 603 Debit for processing error Chargeback
= 604 Debit for multiple charge
= 605 Credit processed as Charge
= 610 Debit as no approval gained
= 613 Debit as Charge on expired/invalid card
= 631 Miscellaneous
= 641 Debit authorized by the merchant
= 642 Debit for insufficient reply
= 643 Debit for no reply to inquiry
= 644 Debit for Fraud Full Recourse
= 645 Incorrect account number
= 646 Debit as credit not received by Cardmember
= 651 Debit as Cardmember paid direct
= 652 Debit for fraudulent transaction
= 653 Debit as Cardmember cancelled goods/services
= 661 Reversal of previous debit
= 689 Not as described or defective merchandise
= 690 Not as described or defective merchandise
= 691 Goods not received
= 692 Debit for unproven rental charge

If unused, this field is character space filled.

=method SERVICE_AGENT_MERCHANT_ID

This field contains the external, third party Service Agent Merchant ID number.
