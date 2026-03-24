/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

create or alter procedure load_bronze as
 begin 
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try 
	     set @batch_start_time = getdate();
		 print '========================================';
		 print 'Loading Bronze Layer';
		 print '========================================';

		 print '----------------------------------------';
		 print 'Loading CRM Tables';
		 print '----------------------------------------';

		 set @start_time = getdate()
		 print '>>> Trancating Table: bronze.crm_cust_info';
		 truncate table bronze.crm_cust_info;
		 print '>>> Inserting Data Into: bronze.crm_cust_info';
		 bulk insert bronze.crm_cust_info 
		 from  'C:\Users\S Rajkumar\Babu\dwh_project\Data_set\Source_crm\cust_info.csv' 
		 with (
				firstrow = 2,
				fieldterminator = ',',
				tablock 
		 );

		 set @end_time = getdate()
		 print '>>> Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		 print '-----------------------------------------------';

		 set @start_time = getdate()
		 print '>>> Trancating Table: bronze.crm_prd_info';
		 truncate table bronze.crm_prd_info;
		 print '>>> Inserting Data Into: bronze.crm_prd_info';
		 bulk insert bronze.crm_prd_info 
		 from  'C:\Users\S Rajkumar\Babu\dwh_project\Data_set\Source_crm\prd_info.csv' 
		 with (
				firstrow = 2,
				fieldterminator = ',',
				tablock 
		 );
		 set @end_time = getdate()
		 print '>>> Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		 print '-----------------------------------------------';

		 set @start_time = getdate()
		 print '>>> Trancating Table:bronze.crm_sale_details';
		 truncate table bronze.crm_sale_details;
		 print '>>> Inserting Data Into: bronze.crm_sale_details';
		 bulk insert bronze.crm_sale_details 
		 from  'C:\Users\S Rajkumar\Babu\dwh_project\Data_set\Source_crm\sales_details.csv' 
		 with (
				firstrow = 2,
				fieldterminator = ',',
				tablock 
		 );
		 set @end_time = getdate()
		 print '>>> Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		 print '-----------------------------------------------';

		 print '----------------------------------------';
		 print 'Loading ERP Tables';
		 print '----------------------------------------';

		 set @start_time = getdate()
		 print '>>> Trancating Table:bronze.erp_cust_az12';

		 truncate table bronze.erp_cust_az12;
		 print '>>> Inserting Data Into: bronze.erp_cust_az12';
		 bulk insert bronze.erp_cust_az12
		 from 'C:\Users\S Rajkumar\Babu\dwh_project\Data_set\Source_erp\cust_az12.csv'

		 with (
				firstrow = 2,
				fieldterminator = ',',
				tablock 
		 );
		 set @end_time = getdate()
		 print '>>> Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		 print '-----------------------------------------------';

		 set @start_time = getdate()
		 print '>>> Trancating Table:bronze.erp_loc_a101';
		 truncate table bronze.erp_loc_a101;
		 print '>>> Inserting Data Into: bronze.erp_loc_a101';
		 bulk insert bronze.erp_loc_a101
		 from 'C:\Users\S Rajkumar\Babu\dwh_project\Data_set\Source_erp\loc_a101.csv'

		 with (
				firstrow = 2,
				fieldterminator = ',',
				tablock 
		 );
		 set @end_time = getdate()
		 print '>>> Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		 print '-----------------------------------------------';

		 set @start_time = getdate()
		 print '>>> Trancating Table:bronze.erp_px_cat_g1v2';
		 truncate table bronze.erp_px_cat_g1v2;
		 print '>>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		 bulk insert bronze.erp_px_cat_g1v2
		 from 'C:\Users\S Rajkumar\Babu\dwh_project\Data_set\Source_erp\px_cat_g1v2.csv'

		 with (
				firstrow = 2,
				fieldterminator = ',',
				tablock 
		 );
		 set @end_time = getdate()
		 print '>>> Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		 print '-----------------------------------------------';
		 set @batch_end_time = getdate()
		 print '================================================';
		 print 'Loading Bronze Layer is completd';
		 print ' Total  Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) As nvarchar) + 'seconds';
	end try 
	begin catch
	 print '=============================================';
	 print 'Error occured During Loading Bronze layer';
	 print 'Error Message' + error_message();
	 print 'Error Message' + cast(error_number() As nvarchar);
	 print 'Error Message' + cast(error_state() as nvarchar);
     print '=============================================';
	end catch
end

