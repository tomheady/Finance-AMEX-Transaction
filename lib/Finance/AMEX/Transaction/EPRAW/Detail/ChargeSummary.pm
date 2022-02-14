package Finance::AMEX::Transaction::EPRAW::Detail::ChargeSummary;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Reconciliation Files (EPRAW) Summary of Charge (SOC) Detail Rows

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
    DISCOUNT_AMOUNT           => [77,  9],
    SERVICE_FEE_AMOUNT        => [86,  7],
    NET_SOC_AMOUNT            => [100, 11],
    DISCOUNT_RATE             => [111, 5],
    SERVICE_FEE_RATE          => [116, 5],
    AMEX_GROSS_AMOUNT         => [142, 11],
    AMEX_ROC_COUNT            => [153, 5],
    TRACKING_ID               => [158, 9],
    TRACKING_ID_DATE          => [158, 3],
    TRACKING_ID_PCID          => [161, 6],
    CPC_INDICATOR             => [167, 1],
    AMEX_ROC_COUNT_POA        => [183, 7],
    SERVICE_AGENT_MERCHANT_ID => [281, 15],

    # DEPRECATED
    OPTIMA_DIVIDEND_AMOUNT => [93,  7],
    OPTIMA_DIVIDEND_RATE   => [121, 5],
    OPTIMA_GROSS_AMOUNT    => [126, 11],
    OPTIMA_ROC_COUNT       => [137, 5],
  };
}

sub type {return 'SOC_DETAIL'}

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
sub DISCOUNT_AMOUNT           {return $_[0]->_get_column('DISCOUNT_AMOUNT')}
sub SERVICE_FEE_AMOUNT        {return $_[0]->_get_column('SERVICE_FEE_AMOUNT')}
sub NET_SOC_AMOUNT            {return $_[0]->_get_column('NET_SOC_AMOUNT')}
sub DISCOUNT_RATE             {return $_[0]->_get_column('DISCOUNT_RATE')}
sub SERVICE_FEE_RATE          {return $_[0]->_get_column('SERVICE_FEE_RATE')}
sub AMEX_GROSS_AMOUNT         {return $_[0]->_get_column('AMEX_GROSS_AMOUNT')}
sub AMEX_ROC_COUNT            {return $_[0]->_get_column('AMEX_ROC_COUNT')}
sub TRACKING_ID               {return $_[0]->_get_column('TRACKING_ID')}
sub TRACKING_ID_DATE          {return $_[0]->_get_column('TRACKING_ID_DATE')}
sub TRACKING_ID_PCID          {return $_[0]->_get_column('TRACKING_ID_PCID')}
sub CPC_INDICATOR             {return $_[0]->_get_column('CPC_INDICATOR')}
sub AMEX_ROC_COUNT_POA        {return $_[0]->_get_column('AMEX_ROC_COUNT_POA')}
sub SERVICE_AGENT_MERCHANT_ID {return $_[0]->_get_column('SERVICE_AGENT_MERCHANT_ID')}

# DEPRECATED
sub OPTIMA_DIVIDEND_AMOUNT {return $_[0]->_get_column('OPTIMA_DIVIDEND_AMOUNT')}
sub OPTIMA_DIVIDEND_RATE   {return $_[0]->_get_column('OPTIMA_DIVIDEND_RATE')}
sub OPTIMA_GROSS_AMOUNT    {return $_[0]->_get_column('OPTIMA_GROSS_AMOUNT')}
sub OPTIMA_ROC_COUNT       {return $_[0]->_get_column('OPTIMA_ROC_COUNT')}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::EPRAW::Detail::ChargeSummary - Object methods for AMEX Reconciliation file summary of charge detail records.

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'EPRAW');
 open my $fh, '<', '/path to EPRAW file' or die "cannot open EPRAW file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'SOC_DETAIL') {
    print $record->AMEX_PROCESS_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an EPRAW  file');
 if ($record->type eq 'SOC_DETAIL') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new L<Finance::AMEX::Transaction::EPRAW::Detail::ChargeSummary> object.

 my $record = Finance::AMEX::Transaction::EPRAW::Detail::ChargeSummary->new(line => $line);

=method type

This will always return the string SOC_DETAIL.

 print $record->type; # SOC_DETAIL

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

This field contains the Detail Record Type code that indicates the type of record used in this transaction. For Summary of Charge (SOC) Detail Records, this entry is always “10”.

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

=method DISCOUNT_AMOUNT

This field contains the total Discount Amount, based on SOC_AMOUNT and DISCOUNT_RATE.

=method SERVICE_FEE_AMOUNT

This field contains the total Service Fee Amount, based on SOC_AMOUNT, and SERVICE_FEE_RATE.

=method NET_SOC_AMOUNT

This field contains the Net SOC (Summary of Charge) Amount submitted to American Express for payment, which is the sum total of SOC_AMOUNT, less DISCOUNT_AMOUNT and SERVICE_FEE_AMOUNT.

=method DISCOUNT_RATE

This field contains the Discount Rate (decimal place value) used to calculate the amount American Express charges a merchant for services provided per the American Express Card Acceptance Agreement.

=method SERVICE_FEE_RATE

This field contains the Service Fee Rate (decimal place value) used to calculate the amount American Express charges a merchant as service fees.

Service fees are assessed only in certain situations and may not apply to all SEs.

=method AMEX_GROSS_AMOUNT

This field contains the gross amount of American Express charges submitted in the original SOC amount.

=method AMEX_ROC_COUNT

This field contains the quantity of American Express charges submitted in this Summary of Charge (SOC). This entry is always
positive, which is indicated by an upper-case alpha code used in place of the last (least significant) digit.

The alpha codes and their numeric equivalents are listed below:

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

Note: In rare instances, the quantity of American Express charges may exceed the five-byte length of this field; and the actual value may be truncated. In this case, this entry should be ignored, and the actual quantity of American Express charges should be obtained from the seven-byte, AMEX_ROC_COUNT_POA field.

For this reason, American Express strongly recommends that Merchant and Authorized Third Party Processor systems use
AMEX_ROC_COUNT_POA, in lieu of this field.

=method TRACKING_ID

This field contains the Tracking ID, which holds SOC processing information.

=method TRACKING_ID_DATE

The Julian date for the tracking id.

=method TRACKING_ID_PCID

Tracking ID PCID

=method CPC_INDICATOR

This field contains the CPC Indicator, which indicates whether the batch that corresponds to this SOC detail record contains CPC/Corporate Purchasing Card (a.k.a., CPS/Corporate Purchasing Solutions Card) transactions.

Valid entries include:

=for :list
= P = CPC/CPS Card transactions (special pricing applied)
= ~ = Non-CPC/CPS Card transactions

Note: Tilde (~) represents a character space.


=method AMEX_ROC_COUNT_POA

This field contains the quantity of American Express charges submitted in this Summary of Charge (SOC). This entry is always positive, which is indicated by an upper-case alpha code used in place of the last (least significant) digit.

The alpha codes and their numeric equivalents are listed below:

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

Important Note for Merchants Using AMEX_ROC_COUNT_POA:

AMEX_ROC_COUNT and AMEX_ROC_COUNT_POA contain the same basic value, up five significant digits. However, for values greater than “9999I” (99,999), AMEX_ROC_COUNT_POA should be used; because the value in AMEX_ROC_COUNT is truncated at five bytes.

=method SERVICE_AGENT_MERCHANT_ID

This field contains the external, third party Service Agent Merchant ID number.

=method OPTIMA_DIVIDEND_AMOUNT (DEPRECATED 2010-10-21)

This field is deprecated.

=method OPTIMA_DIVIDEND_RATE (DEPRECATED 2010-10-21)

This field is deprecated.

=method OPTIMA_GROSS_AMOUNT (DEPRECATED 2010-10-21)

This field is deprecated.

=method OPTIMA_ROC_COUNT (DEPRECATED 2010-10-21)

This field is deprecated.
