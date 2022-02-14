package Finance::AMEX::Transaction::EPPRC::Detail::RecordSummary;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Transaction/Invoice Level Reconciliation (EPPRC) Record of Charge (ROC) Detail Rows

use base 'Finance::AMEX::Transaction::EPPRC::Base';

sub field_map {
  return {

    TLRR_AMEX_PAYEE_NUMBER     => [1,   10],
    TLRR_AMEX_SE_NUMBER        => [11,  10],
    TLRR_SE_UNIT_NUMBER        => [21,  10],
    TLRR_PAYMENT_YEAR          => [31,  4],
    TLRR_PAYMENT_NUMBER        => [35,  8],
    TLRR_PAYMENT_NUMBER_DATE   => [35,  3],
    TLRR_PAYMENT_NUMBER_TYPE   => [38,  1],
    TLRR_PAYMENT_NUMBER_NUMBER => [39,  4],
    TLRR_RECORD_TYPE           => [43,  1],
    TLRR_DETAIL_RECORD_TYPE    => [44,  2],
    TLRR_SE_BUSINESS_DATE      => [46,  7],
    TLRR_AMEX_PROCESS_DATE     => [53,  7],
    TLRR_SOC_INVOICE_NUMBER    => [60,  6],
    TLRR_SOC_AMOUNT            => [66,  13],
    TLRR_ROC_AMOUNT            => [79,  13],
    TLRR_CM_NUMBER             => [92,  15],
    TLRR_CM_REF_NO             => [107, 11],
    TLRR_SE_REF                => [118, 9],
    TLRR_ROC_NUMBER            => [137, 10],
    TLRR_TRAN_DATE             => [147, 7],
    TLRR_SE_REF_POA            => [154, 30],
    NON_COMPLIANT_INDICATOR    => [184, 1],
    NON_COMPLIANT_ERROR_CODE_1 => [185, 4],
    NON_COMPLIANT_ERROR_CODE_2 => [189, 4],
    NON_COMPLIANT_ERROR_CODE_3 => [193, 4],
    NON_COMPLIANT_ERROR_CODE_4 => [197, 4],
    NON_SWIPED_INDICATOR       => [201, 1],
    US_MR_INDICATOR            => [202, 1],
    SE_REJ_IND                 => [203, 2],
    TRANSACTION_TIME           => [205, 6],
    APPROVAL_CODE              => [211, 6],
    TERMINAL_ID                => [217, 8],
    MERCHANT_CATEGORY_CODE     => [225, 4],
    TLRR_CM_NUMB_EXD           => [229, 19],
  };
}

sub type {return 'ROC_DETAIL'}

sub TLRR_AMEX_PAYEE_NUMBER     {return $_[0]->_get_column('TLRR_AMEX_PAYEE_NUMBER')}
sub TLRR_AMEX_SE_NUMBER        {return $_[0]->_get_column('TLRR_AMEX_SE_NUMBER')}
sub TLRR_SE_UNIT_NUMBER        {return $_[0]->_get_column('TLRR_SE_UNIT_NUMBER')}
sub TLRR_PAYMENT_YEAR          {return $_[0]->_get_column('TLRR_PAYMENT_YEAR')}
sub TLRR_PAYMENT_NUMBER        {return $_[0]->_get_column('TLRR_PAYMENT_NUMBER')}
sub TLRR_PAYMENT_NUMBER_DATE   {return $_[0]->_get_column('TLRR_PAYMENT_NUMBER_DATE')}
sub TLRR_PAYMENT_NUMBER_TYPE   {return $_[0]->_get_column('TLRR_PAYMENT_NUMBER_TYPE')}
sub TLRR_PAYMENT_NUMBER_NUMBER {return $_[0]->_get_column('TLRR_PAYMENT_NUMBER_NUMBER')}
sub TLRR_RECORD_TYPE           {return $_[0]->_get_column('TLRR_RECORD_TYPE')}
sub TLRR_DETAIL_RECORD_TYPE    {return $_[0]->_get_column('TLRR_DETAIL_RECORD_TYPE')}
sub TLRR_SE_BUSINESS_DATE      {return $_[0]->_get_column('TLRR_SE_BUSINESS_DATE')}
sub TLRR_AMEX_PROCESS_DATE     {return $_[0]->_get_column('TLRR_AMEX_PROCESS_DATE')}
sub TLRR_SOC_INVOICE_NUMBER    {return $_[0]->_get_column('TLRR_SOC_INVOICE_NUMBER')}
sub TLRR_SOC_AMOUNT            {return $_[0]->_get_column('TLRR_SOC_AMOUNT')}
sub TLRR_ROC_AMOUNT            {return $_[0]->_get_column('TLRR_ROC_AMOUNT')}
sub TLRR_CM_NUMBER             {return $_[0]->_get_column('TLRR_CM_NUMBER')}
sub TLRR_CM_REF_NO             {return $_[0]->_get_column('TLRR_CM_REF_NO')}
sub TLRR_SE_REF                {return $_[0]->_get_column('TLRR_SE_REF')}
sub TLRR_ROC_NUMBER            {return $_[0]->_get_column('TLRR_ROC_NUMBER')}
sub TLRR_TRAN_DATE             {return $_[0]->_get_column('TLRR_TRAN_DATE')}
sub TLRR_SE_REF_POA            {return $_[0]->_get_column('TLRR_SE_REF_POA')}
sub NON_COMPLIANT_INDICATOR    {return $_[0]->_get_column('NON_COMPLIANT_INDICATOR')}
sub NON_COMPLIANT_ERROR_CODE_1 {return $_[0]->_get_column('NON_COMPLIANT_ERROR_CODE_1')}
sub NON_COMPLIANT_ERROR_CODE_2 {return $_[0]->_get_column('NON_COMPLIANT_ERROR_CODE_2')}
sub NON_COMPLIANT_ERROR_CODE_3 {return $_[0]->_get_column('NON_COMPLIANT_ERROR_CODE_3')}
sub NON_COMPLIANT_ERROR_CODE_4 {return $_[0]->_get_column('NON_COMPLIANT_ERROR_CODE_4')}
sub NON_SWIPED_INDICATOR       {return $_[0]->_get_column('NON_SWIPED_INDICATOR')}
sub US_MR_INDICATOR            {return $_[0]->_get_column('US_MR_INDICATOR')}
sub SE_REJ_IND                 {return $_[0]->_get_column('SE_REJ_IND')}
sub TRANSACTION_TIME           {return $_[0]->_get_column('TRANSACTION_TIME')}
sub APPROVAL_CODE              {return $_[0]->_get_column('APPROVAL_CODE')}
sub TERMINAL_ID                {return $_[0]->_get_column('TERMINAL_ID')}
sub MERCHANT_CATEGORY_CODE     {return $_[0]->_get_column('MERCHANT_CATEGORY_CODE')}
sub TLRR_CM_NUMB_EXD           {return $_[0]->_get_column('TLRR_CM_NUMB_EXD')}

1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::EPPRC::Detail::RecordSummary - Object methods for AMEX Transaction/Invoice (ROC) Level detail records.

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'EPPRC');
 open my $fh, '<', '/path to EPPRC file' or die "cannot open EPPRC file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'ROC_DETAIL') {
    print $record->AMEX_PROCESS_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an EPPRC  file');
 if ($record->type eq 'ROC_DETAIL') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new Finance::AMEX::Transaction::EPPRC::Detail::RecordSummary object.

 my $record = Finance::AMEX::Transaction::EPPRC::Detail::RecordSummary->new(line => $line);

=method type

This will always return the string ROC_DETAIL.

 print $record->type; # ROC_DETAIL

=method line

Returns the full line that is represented by this object.

 print $record->line;

=method field_map

Returns an arrayref of hashrefs where the name is the record name and 
the value is an arrayref of the start position and length of that field.

 # print the start position of the TLRR_PAYMENT_YEAR field
 print $record->field_map->[3]->{TLRR_PAYMENT_YEAR}->[0]; # 31

=method TLRR_AMEX_PAYEE_NUMBER

This field contains the Service Establishment (SE) Number of the merchant that received the payment from American Express.

Note: SE Numbers are assigned by American Express.

=method TLRR_AMEX_SE_NUMBER

This field contains the Service Establishment (SE) Number of the merchant being reconciled, which may not necessarily be the same SE receiving payment (see AMEX_PAYEE_NUMBER).

This is the SE Number under which the transactions were submitted, which usually corresponds to the physical location.

=method TLRR_SE_UNIT_NUMBER

This field contains the merchant-assigned SE Unit Number (usually an internal, store identifier code) that corresponds to a specific store or location.

If no value is assigned, this field is character space filled.

=method TLRR_PAYMENT_YEAR

This field contains the Payment Year that corresponds to the entry in the Julian Date subfield of PAYMENT_NUMBER.

=method TLRR_PAYMENT_NUMBER

This field contains the Payment Number, a reference number used by the American Express Payee to reconcile the daily settlement to the daily payment.

=method TLRR_PAYMENT_NUMBER_DATE

The Julian date of the payment.

=method TLRR_PAYMENT_NUMBER_TYPE

An alpha character assigned by the American Express settlement system.

=method TLRR_PAYMENT_NUMBER_NUMBER

The Number of the payment.

=method TLRR_RECORD_TYPE

This field contains the constant literal “3”, a Record Type code that indicates that this is a Record of Charge (ROC) Detail Record.

=method TLRR_DETAIL_RECORD_TYPE

This field contains the Detail Record Type code that corresponds to this record. For Record of Charge (ROC) Detail Records, this entry is always “11”.

=method TLRR_SE_BUSINESS_DATE

This field contains the SE Business Date assigned to this submission by the submitting merchant location.

The format is: YYYYDDD

=for :list
= YYYY = Year
= DDD = Julian Date

=method TLRR_AMEX_PROCESS_DATE

This field contains the American Express Transaction Processing Date, which is used to determine the payment date.

The format is: YYYYDDD

=for :list
= YYYY = Year
= DDD = Julian Date

=method TLRR_SOC_INVOICE_NUMBER

This field contains the Summary of Charge (SOC) Invoice Number.

=method TLRR_SOC_AMOUNT

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

=method TLRR_ROC_AMOUNT

This field contains the Record of Charge (ROC) Amount for a single transaction included in this settlement file.

See TLRR_SOC_AMOUNT for debit and credit codes.

=method TLRR_CM_NUMBER

This field contains the Cardmember (Account) Number that corresponds to this transaction. (Please note that if Card number masking is enabled this field is required to accept alphanumeric characters.)

=method TLRR_CM_REF_NO

This field contains the Cardmember Reference Number assigned to this transaction by the Cardmember, at the time the sale was executed. This data is primarily used in the CPC/Corporate Purchasing Card (a.k.a., CPS/Corporate Purchasing Solutions Card) environment. If this field is populated, this value is used by the Card members organization for tracking and accounting purposes.

=method TLRR_SE_REF

This field is unused and reserved for future use.

Note: This field previously contained the SE Reference Number assigned to this transaction by the merchant, at the time the sale was executed. However, due to size limitations, this data is now transported in TLRR_SE_REF_POA. Occasionally, truncated values from TLRR_SE_REF_POA may be partially duplicated in this field. However, this residual data should be ignored. For details on the SE reference number, see TLRR_SE_REF_POA.

=method TLRR_ROC_NUMBER

This field is unused and reserved for future use.

Note: This field previously contained the ROC Number, or other charge reference number, assigned to this transaction by the merchant, at the time the sale was executed. This data is now transported in TLRR_SE_REF_POA. For details on the SE reference number, see TLRR_SE_REF_POA.

=method TLRR_TRAN_DATE

This field contains the Transaction Date, which is the date the transaction took place (from the TRANSACTION_DATE field in the financial settlement file).

The format is: YYYYDDD

=for :list
= YYYY = Year
= DDD = Julian Date

=method TLRR_SE_REF_POA

This field contains the SE (Invoice) Reference Number assigned to this transaction by the merchant, at the time the sale was executed.

This entry may be a reference to the Record of Charge (ROC), order number, invoice number, or any other merchant-designated combination of letters and numerals that was intended to aid the merchant in the retrieval of supporting documentation, in case of inquiry or other post-transaction correspondence.

=method NON_COMPLIANT_INDICATOR

This field contains the Non-Compliant Indicator.

Valid values include the following:

=for :list
= A = Settlement and/or authorization file did not comply with American Express standards. See NON_COMPLIANT_ERROR_CODE_1 - 4.
= N = Settlement and/or authorization file did not comply with American Express standards.
= ~ = None assessed.

Note: Tilde (~) represents a character space.

=method NON_COMPLIANT_ERROR_CODE_1 NON_COMPLIANT_ERROR_CODE_2 NON_COMPLIANT_ERROR_CODE_3 NON_COMPLIANT_ERROR_CODE_4

These fields contain field-level Non-compliant Error Code(s) applicable to this Record of Charge (ROC).

Valid values include the following:

=for :list
= 2014 = Point of Service Data Code invalid
= 2015 = Approval Code non-numeric
= 2022 = Transaction Identifier Invalid
= 2036 = Approval Code not equal to required length

If unused, this field is character space filled.

Note: One or more of these fields may be populated only if this Record of Charge (ROC) is non-compliant as indicated by the value “A” in the preceding NON-COMPLIANT_INDICATOR field. For more information, see NON-COMPLIANT_INDICATOR.

=method NON_SWIPED_INDICATOR

This field contains the Non-Swiped Indicator. This entry indicates if the American Express or American Express Partner’s Cardmember Account Number for this transaction was manually entered; and either the Card was not present, or the Card’s magnetic stripe or chip could not be read by the POS device. Transactions are reviewed utilizing the Point of Sale Data Code (value “C”) or Authorization Code (value “H”) ”) or Non-Swipe ADJ App-In Code (value “Z”).

Valid values include the following:

=for :list
= C = Non-Swiped
= H = Non-Swiped
= ~ = Non assessed
= Z = Non-Swipe ADJ App-In

Note: Tilde (~) represents a character space.

=method US_MR_INDICATOR

Membership Rewards Only

This field contains a code that indicates if this transaction was processed for payment via the American Express Membership Rewards Pay with Points program.

=for :list
= M = Membership Rewards Pay with Points
= ~ = Normal transaction processing (non-Membership Rewards)

Note: Tilde (~) represents a character space.

=method SE_REJ_IND

Indicates that the ROC was rejected within the American Express payments processing system.

Valid values are:

=for :list
= 20 = ROC was rejected and therefore not paid
= ~ = ROC was accepted and paid

Note: Tilde (~) represents a character space.

=method TRANSACTION_TIME

This field contains the time stamp submitted on the original ROC.

Format: HHMMSS (24-hour clock)

=method APPROVAL_CODE

This field contains the approval code obtained on the authorization request.

=method TERMINAL_ID

This field contains the terminal ID at the merchant location which generated the transaction.

=method MERCHANT_CATEGORY_CODE

This field contains the Merchant Category Code (MCC) submitted n the original ROC.

=method TLRR_CM_NUMB_EXD

This field contains the Card member (Account) Number that corresponds to this transaction. (Please note that if Card number masking is enabled this field is required to accept alphanumeric characters.)
