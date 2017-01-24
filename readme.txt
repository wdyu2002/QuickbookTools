This tool contains 2 basic executables.



csv2iif: Converts tab-delimited csv file into QB importable iif file.
				 This makes it easier to record transactions at the end of year without
				 having to enter each transaction (JOURNAL, CHECK, etc) separately into
				 QB.

				 The tab-delimited csv file must utilize the following columns:
				 		Account (opt):	This is just so that we can track the statement's
				 										origination.
				 		Date: 					This is the date of the transaction, purchase, or
				 										paid invoice.
				 		Tx Type:				GENERAL JOURNAL (ie. general purchase)
				 										INCOME (ie. income from FieldLogix)
				 										CHECK (ie. payments via BOA check)
				 										REIMBURSE: 20% (ie. utilities, office repairs)
				 										REIMBURSE: 50% (ie. cellphone bills)
				 										REIMBURSE: 100% (ie. reimbursable purchase)
				 		Amount:					Cost of the transaction, purchase, or paid invoice.
				 		Debit:					Account to debit from (ie. the expense acct).
				 		Credit:					Account to credit (ie. the bank spending acct).
				 		Description:		Some basic description of the purchase.

				Note: It helps to use an excel file where you can restrict and control
				the various options for Account, Tx Type, Debit, and Credit columns.



assets2iif: Calculates asset depreciation for the year and creates a QB
						importable iif file.
						This executable removes the complexity of manually calculating the
						asset depreciation or tracking the depreciation or residual value.
						Adds entries to the GENERAL JOURNAL for the purchase of the
						product, as well as for the sale of the product.

						Asset are defined in ./hireverse/assets in the given format:

								class Asset_<year_purchased>_<product_name> < Asset
									def initialize
										super({
											:name => "<year_purchased> <product name>",
											:cost => 100.00,
											:purchase_date => "mm/dd/yy",
											:sold_date => "",
											:depreciation_method => "HY_5YR"
											})
									end
								end

						New depreciable assets purchased during the year must be recorded
						as an asset within the ./hireverse/assets directory. Note that
						if an asset is depreciable, that entry should NOT be recorded as
						an expensable cost in the output of csv2iif.

						Where depreciation_method can be one of: HY_5YR, HY_7YR, MQ1_5YR,
						MQ1_7YR, MQ2_5YR, MQ2_7YR, MQ3_5YR, MQ3_7YR, MQ4_5YR, MQ4_7YR, or
						Passenger_Vehicle_2011.

						If any existing assets were sold during the year, set its
						sold_date as "12/31/yy". This will generate an entry marking the
						sale of that asset.

