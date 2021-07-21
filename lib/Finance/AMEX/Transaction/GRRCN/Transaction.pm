package Finance::AMEX::Transaction::GRRCN::Transaction;

use strict;
use warnings;

# ABSTRACT: Parse AMEX Global Reconciliation (GRRCN) Transaction or summary of charge (SOC) Rows

use base 'Finance::AMEX::Transaction::GRRCN::Base';

sub field_map {
  my ($self) = @_;

  return {
    RECORD_TYPE                             => [1, 10],
    PAYEE_MERCHANT_ID                       => [11, 15],
    SETTLEMENT_ACCOUNT_TYPE_CODE            => [26, 3],
    AMERICAN_EXPRESS_PAYMENT_NUMBER         => [29, 10],
    PAYMENT_DATE                            => [39, 8],
    PAYMENT_CURRENCY                        => [47, 3],

    SUBMISSION_MERCHANT_ID                  => [50, 15],
    BUSINESS_SUBMISSION_DATE                => [65, 8],
    AMERICAN_EXPRESS_PROCESSING_DATE        => [73, 18],
    SUBMISSION_INVOICE_NUMBER               => [81, 15],
    SUBMISSION_CURRENCY                     => [96, 3],

    MERCHANT_LOCATION_ID                    => [99, 15],
    INVOICE_REFERENCE_NUMBER                => [114, 30],
    SELLER_ID                               => [144, 20],
    CARDMEMBER_ACCOUNT_NUMBER               => [164, 19],
    INDUSTRY_SPECIFIC_REFERENCE_NUMBER      => [183, 30],
    SUBMISSION_GROSS_AMOUNT                 => [213, 16],
    TRANSACTION_AMOUNT                      => [229, 16],
    TRANSACTION_DATE                        => [245, 8],
    TRANSACTION_TIME                        => [253, 6],
    TRANSACTION_ID                          => [259, 15],
    APPROVAL_CODE                           => [274, 6],
    TERMINAL_ID                             => [280, 10],
    MERCHANT_CATEGORY_CODE                  => [290, 4],
    CARDMEMBER_REFERENCE_NUMBER             => [294, 30],
    ACQUIRER_REFERENCE_NUMBER               => [324, 23],
    DATA_QUALITY_NON_COMPLIANT_INDICATOR    => [347, 1],
    DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_1 => [348, 4],
    DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_2 => [352, 4],
    DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_3 => [356, 4],
    DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_4 => [360, 4],
    NON_SWIPED_INDICATOR                    => [364, 1],
    TRANSACTION_REJECTED_INDICATOR          => [365, 3],
    FIRST_INSTALLMENT_AMOUNT                => [368, 16],
    SUBSEQUENT_INSTALLMENT_AMOUNT           => [384, 16],
    NUMBER_OF_INSTALLMENTS                  => [400, 5],
    INSTALLMENT_NUMBER                      => [405, 5],

    (
      $self->version >= 2.01
      ? ( FILLER => [410, 15] )
      : ()
    ),

    SERVICE_FEE_AMOUNT                      => [425, 16],
    ACCELERATION_AMOUNT                     => [441, 16],
  };
}

sub type {return 'TRANSACTION'}

sub RECORD_TYPE                             {return $_[0]->_get_column('RECORD_TYPE')}
sub PAYEE_MERCHANT_ID                       {return $_[0]->_get_column('PAYEE_MERCHANT_ID')}
sub SETTLEMENT_ACCOUNT_TYPE_CODE            {return $_[0]->_get_column('SETTLEMENT_ACCOUNT_TYPE_CODE')}
sub AMERICAN_EXPRESS_PAYMENT_NUMBER         {return $_[0]->_get_column('AMERICAN_EXPRESS_PAYMENT_NUMBER')}
sub PAYMENT_DATE                            {return $_[0]->_get_column('PAYMENT_DATE')}
sub FILLER                                  {return $_[0]->_get_column('FILLER')}

sub PAYMENT_CURRENCY                        {return $_[0]->_get_column('PAYMENT_CURRENCY')}
sub SUBMISSION_MERCHANT_ID                  {return $_[0]->_get_column('SUBMISSION_MERCHANT_ID')}
sub BUSINESS_SUBMISSION_DATE                {return $_[0]->_get_column('BUSINESS_SUBMISSION_DATE')}
sub AMERICAN_EXPRESS_PROCESSING_DATE        {return $_[0]->_get_column('AMERICAN_EXPRESS_PROCESSING_DATE')}
sub SUBMISSION_INVOICE_NUMBER               {return $_[0]->_get_column('SUBMISSION_INVOICE_NUMBER')}
sub SUBMISSION_CURRENCY                     {return $_[0]->_get_column('SUBMISSION_CURRENCY')}

sub MERCHANT_LOCATION_ID                    {return $_[0]->_get_column('MERCHANT_LOCATION_ID')}
sub INVOICE_REFERENCE_NUMBER                {return $_[0]->_get_column('INVOICE_REFERENCE_NUMBER')}
sub SELLER_ID                               {return $_[0]->_get_column('SELLER_ID')}
sub CARDMEMBER_ACCOUNT_NUMBER               {return $_[0]->_get_column('CARDMEMBER_ACCOUNT_NUMBER')}
sub INDUSTRY_SPECIFIC_REFERENCE_NUMBER      {return $_[0]->_get_column('INDUSTRY_SPECIFIC_REFERENCE_NUMBER')}
sub SUBMISSION_GROSS_AMOUNT                 {return $_[0]->_get_column('SUBMISSION_GROSS_AMOUNT')}
sub TRANSACTION_AMOUNT                      {return $_[0]->_get_column('TRANSACTION_AMOUNT')}
sub TRANSACTION_DATE                        {return $_[0]->_get_column('TRANSACTION_DATE')}
sub TRANSACTION_TIME                        {return $_[0]->_get_column('TRANSACTION_TIME')}
sub TRANSACTION_ID                          {return $_[0]->_get_column('TRANSACTION_ID')}
sub APPROVAL_CODE                           {return $_[0]->_get_column('APPROVAL_CODE')}
sub TERMINAL_ID                             {return $_[0]->_get_column('TERMINAL_ID')}
sub MERCHANT_CATEGORY_CODE                  {return $_[0]->_get_column('MERCHANT_CATEGORY_CODE')}
sub CARDMEMBER_REFERENCE_NUMBER             {return $_[0]->_get_column('CARDMEMBER_REFERENCE_NUMBER')}
sub ACQUIRER_REFERENCE_NUMBER               {return $_[0]->_get_column('ACQUIRER_REFERENCE_NUMBER')}
sub DATA_QUALITY_NON_COMPLIANT_INDICATOR    {return $_[0]->_get_column('DATA_QUALITY_NON_COMPLIANT_INDICATOR')}

sub DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_1 {return $_[0]->_get_column('DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_1')}
sub DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_2 {return $_[0]->_get_column('DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_2')}
sub DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_3 {return $_[0]->_get_column('DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_3')}
sub DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_4 {return $_[0]->_get_column('DATA_QUALITY_NON_COMPLIANT_ERROR_CODE_4')}
sub NON_SWIPED_INDICATOR                    {return $_[0]->_get_column('NON_SWIPED_INDICATOR')}
sub TRANSACTION_REJECTED_INDICATOR          {return $_[0]->_get_column('TRANSACTION_REJECTED_INDICATOR')}
sub FIRST_INSTALLMENT_AMOUNT                {return $_[0]->_get_column('FIRST_INSTALLMENT_AMOUNT')}
sub SUBSEQUENT_INSTALLMENT_AMOUNT           {return $_[0]->_get_column('SUBSEQUENT_INSTALLMENT_AMOUNT')}
sub NUMBER_OF_INSTALLMENTS                  {return $_[0]->_get_column('NUMBER_OF_INSTALLMENTS')}
sub INSTALLMENT_NUMBER                      {return $_[0]->_get_column('INSTALLMENT_NUMBER')}
sub SERVICE_FEE_AMOUNT                      {return $_[0]->_get_column('SERVICE_FEE_AMOUNT')}
sub ACCELERATION_AMOUNT                     {return $_[0]->_get_column('ACCELERATION_AMOUNT')}


1;

__END__

=encoding utf-8

=head1 NAME

Finance::AMEX::Transaction::GRRCN::Transaction - Object methods for AMEX Global Reconciliation (GRRCN) Transaction or summary of charge records.

=head1 SYNOPSIS

 use Finance::AMEX::Transaction;

 my $epraw = Finance::AMEX::Transaction->new(file_type => 'GRRCN');
 open my $fh, '<', '/path to GRRCN file' or die "cannot open GRRCN file: $!";

 while (my $record = $epraw->getline($fh)) {

  if ($record->type eq 'TRANSACTION') {
    print $record->PAYMENT_DATE . "\n";
  }
 }

 # to parse a single line

 my $record = $epraw->parse_line('line from an GRRCN  file');
 if ($record->type eq 'TRANSACTION') {
   ...
 }

=head1 DESCRIPTION

You would not normally be calling this module directly, it is one of the possible return objects from a call to F<Finance::AMEX::Transaction>'s getline method.

=method new

Returns a new L<Finance::AMEX::Transaction::GRRCN::Transaction> object.

 my $record = Finance::AMEX::Transaction::GRRCN::Transaction->new(line => $line);

=method type

This will always return the string TRANSACTION.

 print $record->type; # TRANSACTION

=method line

Returns the full line that is represented by this object.

 print $record->line;

=method RECORD_TYPE

This field contains the Record identifier, which will always be “TRANSACTN” for the Transaction Record.

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

=method SUBMISSION_MERCHANT_ID

This field contains the Service Establishment (SE) Number of the Merchant being reconciled.

=method BUSINESS_SUBMISSION_DATE

The field contains the date assigned by the Merchant or Partner to this submission.

The format is: YYYYMMDD

=for :list
= YYYY = Year
= MM   = Month
= DD   = Day

=method AMERICAN_EXPRESS_PROCESSING_DATE

This field contains the American Express Transaction Processing Date, which is used to determine the payment date scheduled in the American Express Systems.

The format is: YYYYMMDD

=for :list
= YYYY = Year
= MM   = Month
= DD   = Day

=method SUBMISSION_INVOICE_NUMBER

This field contains the Submission Invoice number.

This field may not always be populated if no Submission Invoice Number is assigned.

=method SUBMISSION_CURRENCY

This field contains the Submission Currency Code in Alpha ISO format. Refer to the Global Codes & Information Guide.

=method MERCHANT_LOCATION_ID

This field contains the Merchant-assigned SE Unit Number (such as an internal, store identifier code) that corresponds to a specific store or location.

If unused, this field is character space filled (fixed format) or blank (delimited formats).

=method INVOICE_REFERENCE_NUMBER

This field contains the Invoice/Reference Number assigned by the Merchant or Partner to this transaction at the time the sale was executed.

This is a transaction-level identifier used by the Merchant for identification and reconciliation purposes.

=method SELLER_ID

This field contains the Seller ID, 20-byte code that uniquely identifies a Payment Aggregator or OptBlue ® Participant's specific seller or vendor.

If unused, this field will be character space filled (fixed format) or blank (delimited formats).

=method CARDMEMBER_ACCOUNT_NUMBER

This field contains the Cardmember Account Number that corresponds to this transaction.

Note: if Card number masking is enabled this field is required to accept alphanumeric characters.

JCB card transactions may appear in the reconciliation file. JCB transactions can be distinguished using the Issuer Identification Number (IIN), previously known as bank identification number (BIN), as represented by the first six digits of the credit card number. JCB card numbers begin with ‘35’ and will be 16 digits in length, whereas American Express card numbers begin with ‘37’ and will be 15 digits in length.

=method INDUSTRY_SPECIFIC_REFERENCE_NUMBER

This field contains an industry-specific identifier, which corresponds to the relevant identifier submitted originally by the Merchant, Payment Service Provider or Partner. It will be one of the following IDs, depending on the industry-specific addenda records used when submitting the invoice to American Express:

=for :list
= Airline ticket number
= Rental agreement number
= Insurance policy number
= Rail ticket number
= Travel ticket number

If unused, this position will be space filled (fixed format) or blank (delimited formats).

=method SUBMISSION_GROSS_AMOUNT

This field contains the Gross Amount of American Express charges submitted in the original submission, expressed in the Payment (Settlement) currency.

For formats of amount values, see description in Summary Record, PAYMENT_NET_AMOUNT.

=method TRANSACTION_AMOUNT

This field contains the Transaction or Record of Charge (ROC) Amount for a single transaction.

This value is expressed in the Submission currency.

For formats of amount values, see description in Summary Record, PAYMENT_NET_AMOUNT.

=method TRANSACTION_DATE

This field contains the Transaction Date, which is the date the transaction took place as specified by Merchant in the submission file.

The format is: YYYYMMDD

=for :list
= YYYY = Year
= MM   = Month
= DD   = Day

=method TRANSACTION_TIME

This field contains the time stamp submitted on the original Transaction as specified by Merchant in the submission file.

The format is: HHMMSS

=for :list
= HH = Hours
= MM = Minutes
= SS = Seconds

=method TRANSACTION_ID

This field contains Transaction Identifier (TID), which is a unique tracking number from the Authorization Response message that corresponds to a transaction. This data item reflects the value exactly as entered by the Merchant or Partner in the settlement file.

=method APPROVAL_CODE

This field contains the Approval Code obtained on the Authorization Request.

=method TERMINAL_ID

This field contains the Terminal ID at the Merchant location which generated the transaction. If no Terminal ID was provided then this field will be character space filled (fixed format) or blank (delimited formats).

=method MERCHANT_CATEGORY_CODE

This field contains the Merchant Category Code (MCC) submitted in the original Transaction or ROC. If no code was provided, this field will be character space filled (fixed format) or blank (delimited formats).

=method CARDMEMBER_REFERENCE_NUMBER

This field contains the Reference Number used for CPS (formerly CPC) transactions to help with CPS transaction reconciliation.

If this field is not relevant, it will be character space filled (fixed format) or blank (delimited formats).

=method ACQUIRER_REFERENCE_NUMBER

This field contains the Acquirer Reference Number (ARN),.which is an identifier assigned to a transaction by American Express as soon as the transaction is received from the Merchant.

=method DATA_QUALITY_NON_COMPLIANT_INDICATOR

This field contains the Data Quality Non-Compliant Indicator. This indicates whether the transaction data submitted within the settlement file originally met data quality standards.

Valid values include the following:

=for :list
= Y = Yes
= N = No

This field is only applicable in the U.S. and Canada. Where not relevant this field will be character space filled (fixed format) or blank (delimited formats).

=method DATA_QUALITY_NON-COMPLIANT_ERROR_CODE_1, DATA_QUALITY_NON-COMPLIANT_ERROR_CODE_2, DATA_QUALITY_NON-COMPLIANT_ERROR_CODE_3, DATA_QUALITY_NON-COMPLIANT_ERROR_CODE_4

These fields contain field-level Non-compliant Error Code(s) applicable to this transaction.

Valid values include the following:

=for :list
= 2014 = Point of Service Data Code invalid
= 2015 = Approval Code non-numeric
= 2022 = Transaction Identifier Invalid
= 2036 = Approval Code not equal to required length

For certain Partners [note this is OptBlue] the valid values include the following:

=for :list
= 6415 = Merchant Category Code Prohibited for Program
= 6416 = Merchant Category Code Not Valid for Submitting SE

If unused, this field is character space filled (fixed format) or blank (delimited).

This field is only applicable in the U.S. and Canada.

=method NON_SWIPED_INDICATOR

This field contains the Non-Swiped Indicator. This entry indicates whether the Cardmember Account Number for this transaction was automatically read or not.

For instance, the card may have been manually entered because the card was not present or the card's magnetic strip or chip could not be read by the POS device.

Valid values including the following:

=for :list
= Y = Non-Swiped
= N = Swiped
= ~ = Not known

Note: Tilde (~) represents a character space.

This field is only applicable in the U.S. and Canada.

=method TRANSACTION_REJECTED_INDICATOR

This field indicates that the ROC was rejected within the American Express payments processing system.

Valid values include the following:

=for :list
= REJ = ROC was rejected and therefore not paid
= ~   = ROC was accepted and paid

Note: Tilde (~) represents a character space.

=method FIRST_INSTALLMENT_AMOUNT

This field contains the Total Transaction Amount divided by the number of monthly installments in the Monthly Installment Plan. The last two digits are decimals.

If the division is not exact, the difference is added to this monthly installment (First Installment Amount field).

This field will be populated with zeros (0) if it is not an Installment Plan without interest.

This field is only applicable to certain local market Merchants from Mexico / Argentina.

=method SUBSEQUENT_INSTALLMENT_AMOUNT

This field contains the Total Amount of the transaction divided by the number of monthly installments in the Monthly Installment Plan. The last two digits are decimals.

This field will be populated with zeros (0) if it is not an Installment Plan without interest.

This field is only applicable to certain local market Merchants from Mexico / Argentina.

=method NUMBER_OF_INSTALLMENTS

This field contains the Number of Monthly Installments in the Monthly Installment Plan without interest.

This field will be populated with zeros (0) if it is not an Installment Plan without interest.

This field is only applicable to certain local market Merchants from Mexico / Argentina.

=method INSTALLMENT_NUMBER

This field contains the Monthly Installment Number.

For example: 00006 would represent installment number 6 out of a total of 12 installments. See also NUMBER_OF_INSTALLMENTS.

This field will be populated with zeros (0) if it is not an Installment Plan without interest.

This field is only applicable to certain local market Merchants from Mexico / Argentina.

=method SERVICE_FEE_AMOUNT

This field contains the Discount/Service Fee Amount applied to installments.

Amount is to two decimal places. For formats of amount values, see description in Summary Record, PAYMENT_NET_AMOUNT.

This field is only applicable to certain local market Merchants from Mexico / Argentina.

=method ACCELERATION_AMOUNT

This field contains the Acceleration Fee Amount charged for this single transaction.

If you sum up this field for all ROC's within a SOC, you will have the SUBMISSION_ACCELERATION_FEE_AMOUNT (Submission Record).

This field is only applicable to certain local market Merchants from Mexico / Argentina.
