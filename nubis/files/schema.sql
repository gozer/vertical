 CREATE SCHEMA v_idol;
CREATE SCHEMA v_txtindex;
CREATE SCHEMA autoscale;


CREATE TABLE autoscale.launches
(
    added_by_node varchar(15),
    start_time timestamp,
    end_time timestamp,
    duration_s int,
    reservationid varchar(20),
    ec2_instanceid varchar(20),
    node_address varchar(15),
    node_subnet_cidr varchar(25),
    replace_node_address varchar(15),
    node_public_address varchar(15),
    status varchar(120),
    is_running boolean,
    comment varchar(128)
);


CREATE TABLE autoscale.terminations
(
    queued_by_node varchar(15),
    removed_by_node varchar(15),
    start_time timestamp,
    end_time timestamp,
    duration_s int,
    ec2_instanceid varchar(20),
    node_address varchar(15),
    node_subnet_cidr varchar(25),
    node_public_address varchar(15),
    lifecycle_action_token varchar(128),
    lifecycle_action_asg varchar(128),
    status varchar(128),
    is_running boolean
);


CREATE TABLE autoscale.downNodes
(
    detected_by_node varchar(15),
    trigger_termination_time timestamp,
    node_down_since timestamp,
    ec2_instanceid varchar(20),
    node_address varchar(15),
    node_subnet_cidr varchar(25),
    status varchar(128)
);


CREATE TABLE public.locations
(
    location_id int NOT NULL,
    continent_code varchar(2),
    continent_name varchar(13),
    country_code varchar(2),
    country_name varchar(50),
    region_code varchar(2),
    region_name varchar(50),
    city_name varchar(50),
    latitude float,
    longitude float,
    geohash varchar(6),
    insert_date date
);

ALTER TABLE public.locations ADD CONSTRAINT locations_pk PRIMARY KEY (location_id) DISABLED;

CREATE TABLE public.product_channels
(
    product_channel_id int NOT NULL,
    product_channel varchar(100),
    partner varchar(50)
);

ALTER TABLE public.product_channels ADD CONSTRAINT product_channels_1 PRIMARY KEY (product_channel_id) DISABLED;

CREATE TABLE public.products
(
    product_id int NOT NULL,
    product_guid varchar(36) NOT NULL,
    product_name varchar(20) NOT NULL,
    product_version varchar(30) NOT NULL,
    product_version_major int,
    product_version_minor int,
    product_version_minor_suffix varchar(15),
    product_version_sub_a int,
    product_version_sub_a_suffix varchar(15),
    product_version_sub_b int,
    product_version_sub_b_suffix varchar(15),
    formatted_version_major varchar(7)
);

ALTER TABLE public.products ADD CONSTRAINT products_pk PRIMARY KEY (product_id) DISABLED;

CREATE TABLE public.ffos_dimensional_by_date
(
    _year_quarter varchar(7),
    date varchar(10),
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    isp_name varchar(100),
    device_type varchar(100),
    tot_request_on_date int
);


CREATE TABLE public.f_bugs_snapshot_v2
(
    id  IDENTITY ,
    es_id varchar(255),
    bug_id varchar(255),
    bug_severity varchar(255),
    bug_status varchar(255),
    bug_version_num varchar(255),
    assigned_to varchar(255),
    component varchar(255),
    created_by varchar(255),
    created_ts timestamp,
    modified_by varchar(255),
    modified_ts timestamp,
    op_sys varchar(255),
    priority varchar(255),
    product varchar(255),
    qa_contact varchar(255),
    reported_by varchar(255),
    reporter varchar(255),
    version varchar(255),
    expires_on varchar(255),
    cf_due_date varchar(255),
    target_milestone varchar(255),
    short_desc varchar(1024),
    bug_status_resolution varchar(1024),
    keywords varchar(1024),
    snapshot_date date
);


CREATE TABLE public.f_bugs_status_resolution
(
    bug_id varchar(255),
    bug_severity varchar(55),
    short_desc varchar(1024),
    bug_status varchar(255),
    bug_status_previous varchar(255),
    status_update varchar(255),
    status_change_update date,
    curr_snapshot_date date
);


CREATE TABLE public.mozilla_staff
(
    employee_id varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(512),
    supervisory_organization varchar(255),
    cost_center varchar(255),
    functional_group varchar(255),
    manager_id varchar(255),
    manager_lastname varchar(255),
    manager_firstname varchar(255),
    is_manager varchar(2),
    hire_date date,
    location varchar(255),
    snapshot_date date
);


CREATE TABLE public.firefox_download_counts
(
    date varchar(25),
    country_code varchar(25),
    count int,
    ua_family varchar(128),
    ua_major varchar(128),
    os_family varchar(128),
    product_name varchar(1024),
    product_type varchar(1024),
    download_type varchar(128),
    other varchar(1024),
    locale varchar(50)
);


CREATE TABLE public.adi_firefox_by_date_version_country_locale_channel
(
    ping_date date NOT NULL,
    version varchar(20) NOT NULL DEFAULT '',
    country varchar(80) NOT NULL DEFAULT '',
    locale varchar(50) NOT NULL DEFAULT '',
    release_channel varchar(100) NOT NULL DEFAULT '',
    ADI int
);

ALTER TABLE public.adi_firefox_by_date_version_country_locale_channel ADD CONSTRAINT C_PRIMARY PRIMARY KEY (ping_date, country, locale, version, release_channel) DISABLED;

CREATE TABLE public.a_downloads_locale_location_channel
(
    dates_Year int,
    dates_Month int,
    dates_Day_of_month int,
    dates_Date varchar(10),
    download_products_Name varchar(20),
    download_products_Major varchar(7),
    download_products_Version varchar(30),
    request_types_Type varchar(10),
    download_types_Type varchar(10),
    request_result_Result varchar(10),
    locales_Code varchar(15),
    locations_Continent_name varchar(13),
    locations_Country_name varchar(50),
    download_products_rebuild_Name varchar(20),
    download_products_rebuild_Channel varchar(20),
    download_requests_by_day_Total_Requests int,
    download_requests_by_day_fact_count int
);


CREATE TABLE public.releases
(
    is_released boolean,
    version_int int,
    version varchar(7),
    channel varchar(10),
    merge_date date,
    release_date date,
    product varchar(10)
);


CREATE TABLE public.adi_by_region
(
    yr char(4) NOT NULL,
    mnth char(2) NOT NULL,
    region varchar(50) NOT NULL,
    country_code char(2) NOT NULL,
    domain varchar(50) NOT NULL,
    tot_requests int,
    product varchar(20) NOT NULL
);

ALTER TABLE public.adi_by_region ADD CONSTRAINT C_PRIMARY PRIMARY KEY (yr, mnth, region, country_code, domain, product) DISABLED;

CREATE TABLE public.nagios_log_data
(
    event_occurred_at timestamp,
    incident_type varchar(64),
    host varchar(256),
    service varchar(256),
    status varchar(32),
    notify_by varchar(256),
    description varchar(2048),
    filename varchar(255) DEFAULT ''
);


CREATE TABLE public.snippet_count_20151104
(
    date date NOT NULL,
    ua_family varchar(64),
    ua_major int,
    os_family varchar(64),
    country_code char(2),
    snippet_id varchar(64),
    impression_count int,
    locale varchar(100),
    metric varchar(100),
    user_country char(2),
    campaign varchar(255)
)
PARTITION BY (date_part('month', snippet_count_20151104.date));


CREATE TABLE public.snippet_count_fennec_20151104
(
    utc_time varchar(255),
    local_time varchar(255),
    country_code varchar(255),
    country_name varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    city varchar(255),
    domain_name varchar(255),
    org_name varchar(255),
    isp_name varchar(255),
    request_type varchar(255),
    request_url varchar(255),
    http_status_code varchar(255),
    response_size_in_bytes varchar(255),
    referring_url varchar(255),
    ua_family varchar(255),
    ua_major varchar(255),
    ua_minor varchar(255),
    os_family varchar(255),
    os_major varchar(255),
    os_minor varchar(255),
    device_family varchar(255),
    custom_field_1 varchar(255),
    custom_field_2 varchar(255),
    custom_field_3 varchar(255),
    filename varchar(255),
    snippet_id numeric(20,0),
    snippet_impression_date varchar(255)
);


CREATE TABLE public.vertica_backups
(
    backupDate date,
    sizeBytes int,
    node varchar(50),
    status varchar(15),
    snapshotDate date
);


CREATE TABLE public.adi_dimensional_by_date_test
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20)
);


CREATE TABLE public.v4_submissionwise_v5
(
    submission_date date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    profile_share float,
    intermediate_source varchar(255)
);


CREATE TABLE public.ut_monthly_rollups_old
(
    month char(7),
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    processed date
);


CREATE TABLE public.ut_monthly_rollups
(
    month date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    processed date
);


CREATE TABLE public.v4_submissionwise_v5_test
(
    submission_date date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    profile_share float,
    intermediate_source varchar(255)
);


CREATE TABLE public.search_cohort
(
    channel varchar(50),
    geo char(2),
    is_funnelcake boolean,
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active boolean,
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.fx_desktop_er
(
    activity_date date,
    mau int,
    dau int,
    smooth_dau float,
    er float
);


CREATE TABLE public.fx_desktop_er_by_top_countries
(
    country char(2),
    activity_date date,
    mau int,
    dau int,
    smooth_dau float,
    er float
);


CREATE TABLE public.brain_juicer
(
    month_year date,
    country varchar(80),
    sample_size int,
    brand varchar(50),
    uba_as_io float,
    uba_as_browser float,
    mozilla_bpi float,
    non_profit_cc float,
    opinionated_cc float,
    innovative_cc float,
    inclusive_cc float,
    firefox_bpi float,
    independent float,
    trustworty float,
    non_profit float,
    empowering float,
    aware_health_of_internet float,
    aware_online_priv_sec float,
    aware_open_innovation float,
    aware_decentralization float,
    aware_web_literacy float,
    aware_digital_inclusion float,
    care_online_priv_sec float,
    care_open_innovation float,
    care_decentralization float,
    care_web_literacy float,
    care_inclusion float
);


CREATE TABLE public.statcounter
(
    st_date date,
    browser varchar(100),
    stat float,
    region varchar(75),
    device varchar(50)
);


CREATE TABLE public.v4_monthly
(
    geo varchar(10),
    channel varchar(10),
    os varchar(35),
    v4_date date,
    actives int,
    hours float,
    inactives int,
    new_records int,
    five_of_seven int,
    total_records int,
    crashes int,
    v4_default int,
    google int,
    bing int,
    yahoo int,
    other int
);


CREATE TABLE public.engagement_ratio
(
    day date,
    dau int,
    mau int,
    generated_on date
);


CREATE TABLE public.blocklistDecomposition
(
    bd_date date,
    dayNum int,
    dayOfWeek varchar(25),
    yearFreq float,
    adi float,
    trend float,
    seasonal float,
    weekly float,
    outlier float,
    noise float
);


CREATE TABLE public.fx_adjust_mobile
(
    fx_date date,
    maus float,
    daus float
);


CREATE TABLE public.search_cohort_churn_test
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    is_active varchar(3),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.search_cohort_churn_tmp
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    is_active varchar(3),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.mysql_status_counters
(
    mysql_host_id int,
    status_date date,
    Aborted_clients int,
    Aborted_connects int,
    Binlog_cache_disk_use int,
    Binlog_cache_use int,
    Binlog_stmt_cache_use int,
    Bytes_received int,
    Bytes_sent int,
    Com_admin_commands int,
    Com_begin int,
    Com_change_db int,
    Com_commit int,
    Com_create_db int,
    Com_create_table int,
    Com_delete int,
    Com_insert int,
    Com_insert_select int,
    Com_replace int,
    Com_replace_select int,
    Com_select int,
    Com_set_option int,
    Com_show_create_table int,
    Com_show_databases int,
    Com_show_engine_status int,
    Com_show_fields int,
    Com_show_grants int,
    Com_show_processlist int,
    Com_show_slave_status int,
    Com_show_status int,
    Com_show_tables int,
    Com_show_variables int,
    Com_truncate int,
    Com_update int,
    Connections int,
    Created_tmp_disk_tables int,
    Created_tmp_tables int,
    Handler_commit int,
    Handler_delete int,
    Handler_external_lock int,
    Handler_prepare int,
    Handler_read_first int,
    Handler_read_key int,
    Handler_read_next int,
    Handler_read_rnd int,
    Handler_read_rnd_next int,
    Handler_update int,
    Handler_write int,
    Innodb_buffer_pool_bytes_data int,
    Innodb_buffer_pool_pages_flushed int,
    Innodb_buffer_pool_read_ahead int,
    Innodb_buffer_pool_read_ahead_evicted int,
    Innodb_buffer_pool_read_requests int,
    Innodb_buffer_pool_reads int,
    Innodb_buffer_pool_write_requests int,
    Innodb_data_fsyncs int,
    Innodb_data_read int,
    Innodb_data_reads int,
    Innodb_data_writes int,
    Innodb_data_written int,
    Innodb_dblwr_pages_written int,
    Innodb_dblwr_writes int,
    Innodb_log_write_requests int,
    Innodb_log_writes int,
    Innodb_os_log_fsyncs int,
    Innodb_os_log_written int,
    Innodb_pages_created int,
    Innodb_pages_read int,
    Innodb_pages_written int,
    Innodb_rows_deleted int,
    Innodb_rows_inserted int,
    Innodb_rows_read int,
    Innodb_rows_updated int,
    Innodb_num_open_files int,
    Innodb_available_undo_logs int,
    Key_read_requests int,
    Key_reads int,
    Key_write_requests int,
    Key_writes int,
    Open_table_definitions int,
    Opened_files int,
    Opened_table_definitions int,
    Opened_tables int,
    Queries int,
    Questions int,
    Select_range int,
    Select_scan int,
    Slow_queries int,
    Sort_rows int,
    Sort_scan int,
    Table_locks_immediate int,
    Table_open_cache_hits int,
    Table_open_cache_misses int,
    Uptime int
);


CREATE TABLE public.mysql_host
(
    id  IDENTITY ,
    name varchar(250)
);

ALTER TABLE public.mysql_host ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.mysql_system
(
    mysql_host_id int,
    system_type varchar(250),
    system_os varchar(250),
    system_os_release varchar(250),
    is_virtual boolean,
    virtualized varchar(250),
    processor varchar(250),
    processor_speed varchar(250),
    processor_model varchar(250),
    memory varchar(250),
    memory_free varchar(250),
    disk_size int
);


CREATE TABLE public.mysql_host_metrics
(
    mysql_host_id int,
    metrics_date date,
    version varchar(250),
    full_text_index boolean,
    geospatial boolean,
    ssl boolean,
    binlog_format varchar(250),
    default_storage_engine varchar(250),
    sql_mode varchar(250)
);


CREATE TABLE public.mysql_database
(
    mysql_host_id int,
    database_date date,
    name varchar(250),
    innodb_tables int,
    myisam_tables int,
    csv_tables int
);


CREATE TABLE public.adjust_ios_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_android_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_focus_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.adjust_klar_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.sfmcold
(
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);


CREATE TABLE public.sfmcold_emails_sent_html
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmcold_emails_sent
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmcold_clicks
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmcold_bounces
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.sfmcold_base
(
    id  IDENTITY ,
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);

ALTER TABLE public.sfmcold_base ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.sfmcold_opens
(
    id int NOT NULL,
    value int
);


CREATE TABLE public.cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.raw_scvp_okr
(
    id  IDENTITY ,
    update_date date DEFAULT (now())::date,
    accountable_scvp varchar(250),
    okr varchar(250),
    status long varchar(1000),
    score varchar(10),
    metric_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(250),
    cur_month_status varchar(250),
    next_milestone varchar(250),
    status_owner varchar(250),
    data_source varchar(250),
    data_owner varchar(250)
);

ALTER TABLE public.raw_scvp_okr ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.copy_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.fx_market_share
(
    fx_date date,
    fx_mkt_share float
);


CREATE TABLE public.sfmcold_tmp
(
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);


CREATE TABLE public.fx_product_tmp
(
    geo varchar(10),
    channel varchar(10),
    os varchar(35),
    v4_date date,
    actives int,
    hours float,
    inactives int,
    new_records int,
    five_of_seven int,
    total_records int,
    crashes int,
    v4_default int,
    google int,
    bing int,
    yahoo int,
    other int,
    dau int,
    adi int
);


CREATE TABLE public.org_okr_stage
(
    type varchar(50),
    status varchar(10),
    okr varchar(250),
    responsible varchar(250),
    monthly_status varchar(250),
    next_major_milestone varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    score varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    mozilla_okr varchar(50),
    org_level_okr varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);


CREATE TABLE public.org_okr_group
(
    id  IDENTITY ,
    ts timestamp DEFAULT now(),
    name varchar(255)
);

ALTER TABLE public.org_okr_group ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED;

CREATE TABLE public.org_okr_type
(
    type_id  IDENTITY ,
    group_id int,
    duration varchar(255),
    okr_type varchar(250),
    status varchar(50),
    okr_name varchar(255),
    responsible varchar(255),
    monthly_status varchar(255),
    next_major_milestone varchar(250),
    score varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);

ALTER TABLE public.org_okr_type ADD CONSTRAINT C_PRIMARY PRIMARY KEY (type_id) DISABLED;

CREATE TABLE public.org_okr_keyresult
(
    type_id int,
    duration varchar(255),
    okr_type varchar(250),
    status varchar(50),
    kr_name varchar(255),
    responsible varchar(255),
    monthly_status varchar(255),
    next_major_milestone varchar(250),
    score varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);


CREATE TABLE public.search_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.net_neutrality_petition
(
    ts timestamp,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    locale char(5)
);


CREATE TABLE public.open_data_day
(
    ts timestamp,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    locale char(5)
);


CREATE TABLE public.sf_donation_count
(
    opp_name varchar(20),
    opp_type varchar(50),
    lead_source varchar(50),
    amount float,
    close_date date,
    next_step varchar(50),
    stage varchar(20),
    probability int,
    fiscal_period char(7),
    age float,
    created_date date,
    opp_owner varchar(50),
    owner_role varchar(50),
    account_name varchar(50)
);


CREATE TABLE public.statcounter_monthly
(
    st_date date,
    stat float
);


CREATE TABLE public.tmp_search_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE public.fhr_rollups_monthly_base
(
    vendor varchar(50),
    name varchar(50),
    channel varchar(50),
    os varchar(50),
    osdetail varchar(50),
    distribution varchar(50),
    locale varchar(50),
    geo varchar(50),
    version varchar(50),
    isstdprofile varchar(50),
    stdchannel varchar(50),
    stdos varchar(50),
    distribtype varchar(50),
    snapshot varchar(50),
    granularity varchar(50),
    timeStart varchar(50),
    timeEnd varchar(50),
    tTotalProfiles int,
    tExistingProfiles int,
    tNewProfiles int,
    tActiveProfiles int,
    tInActiveProfiles int,
    tActiveDays int,
    tTotalSeconds int,
    tActiveSeconds int,
    tNumSessions int,
    tCrashes int,
    tTotalSearch int,
    tGoogleSearch int,
    tYahooSearch int,
    tBingSearch int,
    tOfficialSearch int,
    tIsDefault int,
    tIsActiveProfileDefault int,
    t5outOf7 int,
    tChurned int,
    tHasUP int
);


CREATE TABLE public.fhr_rollups_monthly_base_2015
(
    vendor varchar(50),
    name varchar(50),
    channel varchar(50),
    os varchar(50),
    osdetail varchar(50),
    distribution varchar(50),
    locale varchar(50),
    geo varchar(50),
    version varchar(50),
    isstdprofile varchar(50),
    stdchannel varchar(50),
    stdos varchar(50),
    distribtype varchar(50),
    snapshot varchar(50),
    granularity varchar(50),
    timeStart varchar(50),
    timeEnd varchar(50),
    tTotalProfiles int,
    tExistingProfiles int,
    tNewProfiles int,
    tActiveProfiles int,
    tInActiveProfiles int,
    tActiveDays int,
    tTotalSeconds int,
    tActiveSeconds int,
    tNumSessions int,
    tCrashes int,
    tTotalSearch int,
    tGoogleSearch int,
    tYahooSearch int,
    tBingSearch int,
    tOfficialSearch int,
    tIsDefault int,
    tIsActiveProfileDefault int,
    t5outOf7 int,
    tChurned int,
    tHasUP int
);


CREATE TABLE public.churn_cohort
(
    channel varchar(50),
    country char(2),
    is_funnelcake boolean,
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    week_since_acquisition int,
    is_active boolean,
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE public.fx_attribution
(
    profiles_count int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250)
);


CREATE TABLE public.copy_adi_dimensional_by_date_s3
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20) DEFAULT ''
);


CREATE TABLE public.snippet_count
(
    date date NOT NULL,
    ua_family varchar(64),
    ua_major int,
    os_family varchar(64),
    country_code char(2),
    snippet_id varchar(64),
    impression_count int,
    locale varchar(100),
    metric varchar(100) DEFAULT '',
    user_country char(2),
    campaign varchar(255)
)
PARTITION BY (date_part('month', snippet_count.date));


CREATE TABLE public.ut_desktop_daily_active_users_extended
(
    day date,
    mau int,
    dau int,
    smooth_dau float
);


CREATE TABLE public.mozilla_staff_plus
(
    employee_id varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(512),
    supervisory_organization varchar(255),
    cost_center varchar(255),
    functional_group varchar(255),
    manager_id varchar(255),
    manager_lastname varchar(255),
    manager_firstname varchar(255),
    manager_email varchar(512),
    is_manager varchar(2),
    hire_date date,
    location varchar(255),
    home_city varchar(255),
    home_country varchar(255),
    home_postal varchar(255),
    desk_number varchar(255),
    snapshot_date date
);


CREATE TABLE public.pocket_mobile_daily_active_users
(
    activity_date date,
    platform varchar(255),
    dau int,
    wau_rolling_7 int,
    mau_rolling_30 int,
    mau_rolling_31 int,
    mau_rolling_28 int,
    app varchar(6) DEFAULT 'Pocket'
);


CREATE TABLE public.ut_clients_daily
(
    client_id varchar(255),
    submission_date_s3 date,
    os varchar(255),
    city varchar(255),
    geo_subdivision1 varchar(255),
    country varchar(255),
    search_count_all_sum int,
    profile_age_in_days int,
    subsession_hours_sum float,
    active_hours_sum float,
    pageviews float
);


CREATE TABLE public.ut_clients_daily_ltv
(
    client_id varchar(255),
    max_submission_date date,
    os varchar(255),
    city varchar(255),
    geo_subdivision1 varchar(255),
    country varchar(255),
    total_search_count_all_sum int,
    max_profile_age_in_days int,
    total_subsession_hours_sum float,
    total_active_hours_sum float,
    total_pageviews float,
    frequency float,
    recency float,
    customer_age int,
    avg_session_value float,
    predicted_searches_14_days float,
    alive_probability float,
    predicted_clv_12_months float,
    historical_searches int,
    historical_clv float,
    days_since_last_active int,
    user_status varchar(20),
    calc_date date,
    total_clv float
);


CREATE TABLE public.ut_clients_daily_aggr
(
    calc_date date,
    attribute varchar(255),
    value varchar(255),
    count int,
    mean_predicted_clv_12_months float,
    mean_historical_searches float,
    mean_historical_clv float,
    median_predicted_clv_12_months float,
    median_historical_searches float,
    median_historical_clv float,
    lower_95ci_predicted_clv_12_months float,
    upper_95ci_predicted_clv_12_months float,
    lower_95ci_historical_searches float,
    upper_95ci_historical_searches float,
    lower_95ci_historical_clv float,
    upper_95ci_historical_clv float,
    lower_99ci_predicted_clv_12_months float,
    upper_99ci_predicted_clv_12_months float,
    lower_99ci_historical_searches float,
    upper_99ci_historical_searches float,
    lower_99ci_historical_clv float,
    upper_99ci_historical_clv float
);


CREATE TABLE public.reviews
(
    ID varchar(80) NOT NULL,
    Store varchar(80) NOT NULL,
    Device varchar(80) NOT NULL,
    Source varchar(80) NOT NULL,
    Country varchar(80),
    "Review Date" date NOT NULL,
    Version float NOT NULL,
    Rating varchar(80),
    "Original Reviews" varchar(4000) NOT NULL,
    "Translated Reviews" varchar(4000) NOT NULL,
    Sentiment varchar(80) NOT NULL,
    Spam int,
    "Verb Phrases" varchar(4000),
    "Noun Phrases" varchar(4000),
    "Clear Filters" varchar(80)
);

ALTER TABLE public.reviews ADD CONSTRAINT C_PRIMARY PRIMARY KEY (ID) DISABLED;

CREATE TABLE public.categorization
(
    ID varchar(80) NOT NULL,
    Feature varchar(80) NOT NULL,
    Component varchar(80) NOT NULL,
    theAction varchar(4000)
);


CREATE TABLE public.key_issue
(
    ID varchar(80) NOT NULL,
    "Key Issue" varchar(80) NOT NULL
);


CREATE TABLE public.ut_clients_daily_ltv_test
(
    client_id varchar(255),
    max_submission_date date,
    os varchar(255),
    city varchar(255),
    geo_subdivision1 varchar(255),
    country varchar(255),
    total_search_count_all_sum int,
    max_profile_age_in_days int,
    total_subsession_hours_sum float,
    total_active_hours_sum float,
    total_pageviews float,
    frequency float,
    recency float,
    customer_age int,
    avg_session_value float,
    predicted_searches_14_days float,
    alive_probability float,
    predicted_clv_12_months float,
    historical_searches int,
    historical_clv float,
    days_since_last_active int,
    user_status varchar(20),
    calc_date date,
    total_clv float
);


CREATE TABLE public.ut_clients_search_history
(
    client_id varchar(255),
    submission_date_s3 date,
    sap int
);

ALTER TABLE public.ut_clients_search_history ADD CONSTRAINT C_UNIQUE UNIQUE (client_id, submission_date_s3) DISABLED;

CREATE TABLE public.ut_clients_daily_details
(
    client_id varchar(255),
    os varchar(255),
    os_version varchar(255),
    city varchar(255),
    geo_subdivision1 varchar(255),
    geo_subdivision2 varchar(255),
    country varchar(255),
    default_search_engine varchar(255),
    default_search_engine_data_submission_url varchar(255),
    default_search_engine_data_load_path varchar(255),
    default_search_engine_data_origin varchar(255),
    e10s_enabled boolean,
    channel varchar(255),
    locale varchar(255),
    is_default_browser boolean,
    memory_mb int,
    os_service_pack_major float,
    os_service_pack_minor float,
    sample_id varchar(255),
    profile_creation_date date,
    profile_age_in_days int,
    active_addons_count_mean float,
    sync_configured boolean,
    sync_count_desktop_sum float,
    sync_count_mobile_sum float,
    places_bookmarks_count_mean float,
    timezone_offset int,
    attribution_site varchar(255),
    source varchar(255),
    medium varchar(255),
    campaign varchar(255),
    content varchar(255),
    submission_date_s3 date,
    max_activity_date date,
    activity_group varchar(255)
);

ALTER TABLE public.ut_clients_daily_details ADD CONSTRAINT C_UNIQUE UNIQUE (client_id, submission_date_s3) DISABLED;

CREATE TABLE public.ut_country_revenue
(
    country_code varchar(10),
    yyyymm varchar(6),
    rev_per_search float
);

ALTER TABLE public.ut_country_revenue ADD CONSTRAINT C_UNIQUE UNIQUE (country_code, yyyymm) DISABLED;

CREATE TABLE public.ut_clients_ltv
(
    client_id varchar(255),
    frequency float,
    recency float,
    customer_age int,
    avg_session_value float,
    predicted_searches_14_days float,
    alive_probability float,
    predicted_clv_12_months float,
    historical_searches int,
    historical_clv float,
    total_clv float,
    days_since_last_active int,
    user_status varchar(20),
    calc_date date
);

ALTER TABLE public.ut_clients_ltv ADD CONSTRAINT C_UNIQUE UNIQUE (client_id, calc_date) DISABLED;

CREATE TABLE public.ut_country_revenue_mock
(
    country_code varchar(10),
    yyyymm varchar(6),
    rev_per_search float
);

ALTER TABLE public.ut_country_revenue_mock ADD CONSTRAINT C_UNIQUE UNIQUE (country_code, yyyymm) DISABLED;

CREATE TABLE public.ut_clients_daily_details_old
(
    client_id varchar(255),
    os varchar(255),
    os_version varchar(255),
    city varchar(255),
    geo_subdivision1 varchar(255),
    geo_subdivision2 varchar(255),
    country varchar(255),
    default_search_engine varchar(255),
    default_search_engine_data_submission_url varchar(255),
    default_search_engine_data_load_path varchar(255),
    default_search_engine_data_origin varchar(255),
    e10s_enabled boolean,
    channel varchar(255),
    locale varchar(255),
    is_default_browser boolean,
    memory_mb int,
    os_service_pack_major float,
    os_service_pack_minor float,
    sample_id varchar(255),
    profile_creation_date date,
    profile_age_in_days int,
    active_addons_count_mean float,
    sync_configured boolean,
    sync_count_desktop_sum float,
    sync_count_mobile_sum float,
    places_bookmarks_count_mean float,
    timezone_offset int,
    attribution_site varchar(255),
    source varchar(255),
    medium varchar(255),
    campaign varchar(255),
    content varchar(255),
    submission_date_s3 date,
    max_activity_date date,
    activity_group varchar(255)
);

ALTER TABLE public.ut_clients_daily_details_old ADD CONSTRAINT C_UNIQUE UNIQUE (client_id, submission_date_s3) DISABLED;

CREATE TABLE public.sfmc_events
(
    send_id int,
    subscriber_id int,
    list_id int,
    event_date timestamp,
    event_type varchar(10),
    send_url_id int,
    url_id int,
    url varchar(255),
    alias varchar(255),
    batch_id int,
    triggered_send_external_key varchar(255),
    source_file varchar(255)
);


CREATE TABLE public.sfmc_subscribers
(
    subscriber_id int,
    status varchar(20),
    date_held timestamp,
    date_created timestamp,
    date_unsubscribed timestamp,
    source_file varchar(255)
);


CREATE TABLE public.sfmc_send_jobs
(
    send_id int,
    from_name varchar(50),
    from_email varchar(50),
    sched_time timestamp,
    sent_time timestamp,
    subject varchar(255),
    email_name varchar(255),
    triggered_send_external_key varchar(255),
    send_definition_external_key int,
    job_status varchar(20),
    preview_url varchar(255),
    is_multipart boolean,
    additional varchar(255),
    source_file varchar(255)
);


CREATE TABLE public.sf_summary
(
    date date,
    rollup_name varchar(50),
    rollup_value int,
    mailing_country varchar(255),
    email_language varchar(10),
    email_format varchar(1)
);


CREATE TABLE public.ut_clients_aggr
(
    calc_date date,
    attribute varchar(255),
    value varchar(255),
    count_hltv int,
    mean_hltv float,
    mode_hltv float,
    ptile10_hltv float,
    ptile25_hltv float,
    median_hltv float,
    ptile75_hltv float,
    ptile90_hltv float,
    std_hltv float,
    skew_hltv float,
    kurtosis_hltv float,
    margin_err_90_hltv float,
    ci90_lower_hltv float,
    ci90_upper_hltv float,
    margin_err_95_hltv float,
    ci95_lower_hltv float,
    ci95_upper_hltv float,
    margin_err_99_hltv float,
    ci99_lower_hltv float,
    ci99_upper_hltv float,
    count_pltv int,
    mean_pltv float,
    mode_pltv float,
    ptile10_pltv float,
    ptile25_pltv float,
    median_pltv float,
    ptile75_pltv float,
    ptile90_pltv float,
    std_pltv float,
    skew_pltv float,
    kurtosis_pltv float,
    margin_err_90_pltv float,
    ci90_lower_pltv float,
    ci90_upper_pltv float,
    margin_err_95_pltv float,
    ci95_lower_pltv float,
    ci95_upper_pltv float,
    margin_err_99_pltv float,
    ci99_lower_pltv float,
    ci99_upper_pltv float,
    count_tltv int,
    mean_tltv float,
    mode_tltv float,
    ptile10_tltv float,
    ptile25_tltv float,
    median_tltv float,
    ptile75_tltv float,
    ptile90_tltv float,
    std_tltv float,
    skew_tltv float,
    kurtosis_tltv float,
    margin_err_90_tltv float,
    ci90_lower_tltv float,
    ci90_upper_tltv float,
    margin_err_95_tltv float,
    ci95_lower_tltv float,
    ci95_upper_tltv float,
    margin_err_99_tltv float,
    ci99_lower_tltv float,
    ci99_upper_tltv float,
    count_historical_searches int,
    mean_historical_searches float,
    mode_historical_searches float,
    ptile10_historical_searches float,
    ptile25_historical_searches float,
    median_historical_searches float,
    ptile75_historical_searches float,
    ptile90_historical_searches float,
    std_historical_searches float,
    skew_historical_searches float,
    kurtosis_historical_searches float,
    margin_err_90_historical_searches float,
    ci90_lower_historical_searches float,
    ci90_upper_historical_searches float,
    margin_err_95_historical_searches float,
    ci95_lower_historical_searches float,
    ci95_upper_historical_searches float,
    margin_err_99_historical_searches float,
    ci99_lower_historical_searches float,
    ci99_upper_historical_searches float,
    count_customer_age int,
    mean_customer_age float,
    mode_customer_age float,
    ptile10_customer_age float,
    ptile25_customer_age float,
    median_customer_age float,
    ptile75_customer_age float,
    ptile90_customer_age float,
    std_customer_age float,
    skew_customer_age float,
    kurtosis_customer_age float,
    margin_err_90_customer_age float,
    ci90_lower_customer_age float,
    ci90_upper_customer_age float,
    margin_err_95_customer_age float,
    ci95_lower_customer_age float,
    ci95_upper_customer_age float,
    margin_err_99_customer_age float,
    ci99_lower_customer_age float,
    ci99_upper_customer_age float
);


CREATE TABLE public.credentials
(
    user_name varchar(80),
    account varchar(80),
    aws_access_key_id varchar(80),
    aws_secret_access_key varchar(80)
);


CREATE TABLE public.f_bugs_status_changes
(
    bug_id varchar(255),
    bug_severity varchar(255),
    bug_status_current varchar(255),
    bug_status_previous varchar(255),
    bug_version_num varchar(255),
    assigned_to varchar(255),
    component varchar(255),
    created_by varchar(255),
    created_ts timestamp,
    modified_by varchar(255),
    modified_ts timestamp,
    op_sys varchar(255),
    priority varchar(255),
    product varchar(255),
    qa_contact varchar(255),
    reported_by varchar(255),
    reporter varchar(255),
    version varchar(255),
    expires_on varchar(255),
    cf_due_date varchar(255),
    target_milestone varchar(255),
    keywords varchar(1024),
    snapshot_date date,
    load_date date,
    load_source varchar(100)
);


CREATE TABLE public.snippet_count_fennec
(
    utc_time varchar(255),
    local_time varchar(255),
    country_code varchar(255),
    country_name varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    city varchar(255),
    domain_name varchar(255),
    org_name varchar(255),
    isp_name varchar(255),
    request_type varchar(255),
    request_url varchar(255),
    http_status_code varchar(255),
    response_size_in_bytes varchar(255),
    referring_url varchar(255),
    ua_family varchar(255),
    ua_major varchar(255),
    ua_minor varchar(255),
    os_family varchar(255),
    os_major varchar(255),
    os_minor varchar(255),
    device_family varchar(255),
    custom_field_1 varchar(255),
    custom_field_2 varchar(255),
    custom_field_3 varchar(255),
    filename varchar(255),
    snippet_id numeric(20,0),
    snippet_impression_date varchar(255)
);


CREATE TABLE public.user_locales
(
    raw_locale varchar(255),
    normalized_locale varchar(255)
);


CREATE TABLE public.redash_focus_retention
(
    os varchar(10),
    cohort date,
    week date,
    cohort_size int,
    weeK_num int,
    active_users int
);


CREATE TABLE public.mobile_daily_active_users
(
    app varchar(20),
    os varchar(20),
    day date,
    dau int,
    smooth_dau float,
    wau int,
    mau int,
    weekly_engagement numeric(5,2),
    monthly_engagement numeric(5,2)
);


CREATE TABLE public.adjust_fennec_retention_by_os
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4)
);


CREATE TABLE public.adjust_ios_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_android_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE public.adjust_focus_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.adjust_klar_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE public.sf_donations
(
    opp_name varchar(20),
    amount numeric(18,2),
    contact_id varchar(50)
);


CREATE TABLE public.sf_foundation_signups
(
    contact_id varchar(50),
    signup_date timestamptz
);


CREATE TABLE public.sf_copyright_petition
(
    contact_id varchar(50),
    signed_on_date date
);


CREATE TABLE public.sf_contacts
(
    id varchar(50),
    created_date timestamp,
    email varchar(255),
    email_format varchar(1),
    contact_name varchar(255),
    email_language varchar(10),
    signup_source_url varchar(500),
    confirmation_miti_subscriber boolean,
    sub_apps_and_hacks boolean,
    sub_firefox_and_you boolean,
    sub_firefox_accounts_journey boolean,
    sub_mozilla_foundation boolean,
    sub_miti_subscriber boolean,
    sub_mozilla_leadership_network boolean,
    sub_mozilla_learning_network boolean,
    sub_webmaker boolean,
    sub_mozillians_nda boolean,
    sub_open_innovation_subscriber boolean,
    subscriber boolean,
    sub_test_flight boolean,
    sub_test_pilot boolean,
    sub_view_source_global boolean,
    sub_view_source_namerica boolean,
    double_opt_in boolean,
    unengaged boolean,
    email_opt_out boolean,
    mailing_country varchar(255)
);


CREATE TABLE public.adjust_retention
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4),
    app varchar(10)
);


CREATE TABLE public.adjust_daily_active_users
(
    adj_date date,
    os varchar(10),
    daus float,
    waus float,
    maus float,
    installs int,
    app varchar(10)
);


CREATE TABLE public.adjust_retention_test
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4),
    app varchar(10)
);


CREATE TABLE public.adjust_daily_active_users_test
(
    adj_date date,
    os varchar(10),
    daus float,
    waus float,
    maus float,
    installs int,
    app varchar(10)
);


CREATE TABLE public.last_updated
(
    name varchar(100) NOT NULL,
    updated_at timestamp,
    updated_by varchar(255)
);

ALTER TABLE public.last_updated ADD CONSTRAINT C_PRIMARY PRIMARY KEY (name) DISABLED;

CREATE TABLE public.ut_desktop_daily_active_users
(
    day date,
    mau int,
    dau int,
    smooth_dau float,
    engagement_ratio numeric(5,2)
);


CREATE TABLE public.test
(
    id int
);


CREATE TABLE public.opt_dates
(
    date_id int NOT NULL,
    year int,
    month int,
    day_of_year int,
    day_of_month int,
    day_of_week int,
    week_of_year int,
    day_of_week_desc varchar(10),
    day_of_week_short_desc varchar(3),
    month_desc varchar(10),
    month_short_desc varchar(3),
    quarter int,
    is_weekday varchar(1),
    date date
);

ALTER TABLE public.opt_dates ADD CONSTRAINT C_PRIMARY PRIMARY KEY (date_id) DISABLED;

CREATE TABLE public.country_names
(
    code varchar(10),
    country varchar(100)
);


CREATE TABLE public.copy_adi_dimensional_by_date
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20) DEFAULT ''
);


CREATE PROJECTION autoscale.launches_super /*+basename(launches),createtype(P)*/ 
(
 added_by_node,
 start_time,
 end_time,
 duration_s,
 reservationid,
 ec2_instanceid,
 node_address,
 node_subnet_cidr,
 replace_node_address,
 node_public_address,
 status,
 is_running,
 comment
)
AS
 SELECT launches.added_by_node,
        launches.start_time,
        launches.end_time,
        launches.duration_s,
        launches.reservationid,
        launches.ec2_instanceid,
        launches.node_address,
        launches.node_subnet_cidr,
        launches.replace_node_address,
        launches.node_public_address,
        launches.status,
        launches.is_running,
        launches.comment
 FROM autoscale.launches
 ORDER BY launches.start_time
UNSEGMENTED ALL NODES;

CREATE PROJECTION autoscale.terminations_super /*+basename(terminations),createtype(P)*/ 
(
 queued_by_node,
 removed_by_node,
 start_time,
 end_time,
 duration_s,
 ec2_instanceid,
 node_address,
 node_subnet_cidr,
 node_public_address,
 lifecycle_action_token,
 lifecycle_action_asg,
 status,
 is_running
)
AS
 SELECT terminations.queued_by_node,
        terminations.removed_by_node,
        terminations.start_time,
        terminations.end_time,
        terminations.duration_s,
        terminations.ec2_instanceid,
        terminations.node_address,
        terminations.node_subnet_cidr,
        terminations.node_public_address,
        terminations.lifecycle_action_token,
        terminations.lifecycle_action_asg,
        terminations.status,
        terminations.is_running
 FROM autoscale.terminations
 ORDER BY terminations.start_time
UNSEGMENTED ALL NODES;

CREATE PROJECTION autoscale.downNodes_super /*+basename(downNodes),createtype(P)*/ 
(
 detected_by_node,
 trigger_termination_time,
 node_down_since,
 ec2_instanceid,
 node_address,
 node_subnet_cidr,
 status
)
AS
 SELECT downNodes.detected_by_node,
        downNodes.trigger_termination_time,
        downNodes.node_down_since,
        downNodes.ec2_instanceid,
        downNodes.node_address,
        downNodes.node_subnet_cidr,
        downNodes.status
 FROM autoscale.downNodes
 ORDER BY downNodes.detected_by_node,
          downNodes.trigger_termination_time,
          downNodes.node_down_since,
          downNodes.ec2_instanceid,
          downNodes.node_address,
          downNodes.node_subnet_cidr,
          downNodes.status
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.locations_super_node0001 /*+basename(locations_super)*/ 
(
 location_id,
 continent_code ENCODING RLE,
 continent_name ENCODING RLE,
 country_code ENCODING RLE,
 country_name ENCODING RLE,
 region_code,
 region_name,
 city_name,
 latitude,
 longitude,
 geohash,
 insert_date
)
AS
 SELECT locations.location_id,
        locations.continent_code,
        locations.continent_name,
        locations.country_code,
        locations.country_name,
        locations.region_code,
        locations.region_name,
        locations.city_name,
        locations.latitude,
        locations.longitude,
        locations.geohash,
        locations.insert_date
 FROM public.locations
 ORDER BY locations.continent_code,
          locations.continent_name,
          locations.country_code,
          locations.country_name
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.product_channels_super_node2_cm_metricsdb02
(
 product_channel_id,
 product_channel,
 partner
)
AS
 SELECT product_channels.product_channel_id,
        product_channels.product_channel,
        product_channels.partner
 FROM public.product_channels
 ORDER BY product_channels.product_channel_id,
          product_channels.product_channel
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.product_channels_partner_unseg_super_node0001 /*+basename(product_channels_partner_unseg_super)*/ 
(
 partner,
 product_channel
)
AS
 SELECT product_channels.partner,
        product_channels.product_channel
 FROM public.product_channels
 ORDER BY product_channels.partner,
          product_channels.product_channel
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.product_channels_partner2_unseg_super_node0001 /*+basename(product_channels_partner2_unseg_super)*/ 
(
 partner
)
AS
 SELECT product_channels.partner
 FROM public.product_channels
 ORDER BY product_channels.partner
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.products_super_node0001 /*+basename(products_super)*/ 
(
 product_id,
 product_guid ENCODING RLE,
 product_name ENCODING RLE,
 product_version,
 product_version_major ENCODING RLE,
 product_version_minor ENCODING RLE,
 product_version_minor_suffix,
 product_version_sub_a ENCODING RLE,
 product_version_sub_a_suffix,
 product_version_sub_b ENCODING RLE,
 product_version_sub_b_suffix,
 formatted_version_major
)
AS
 SELECT products.product_id,
        products.product_guid,
        products.product_name,
        products.product_version,
        products.product_version_major,
        products.product_version_minor,
        products.product_version_minor_suffix,
        products.product_version_sub_a,
        products.product_version_sub_a_suffix,
        products.product_version_sub_b,
        products.product_version_sub_b_suffix,
        products.formatted_version_major
 FROM public.products
 ORDER BY products.product_version_sub_a,
          products.product_version_minor,
          products.product_version_major,
          products.product_version_sub_b,
          products.product_guid,
          products.product_name
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.ffos_dimensional_by_date_unseg_super_node0001 /*+basename(ffos_dimensional_by_date_unseg_super)*/ 
(
 _year_quarter,
 date,
 product,
 v_prod_major,
 prod_os,
 v_prod_os,
 continent_code,
 cntry_code,
 isp_name,
 device_type,
 tot_request_on_date
)
AS
 SELECT ffos_dimensional_by_date._year_quarter,
        ffos_dimensional_by_date.date,
        ffos_dimensional_by_date.product,
        ffos_dimensional_by_date.v_prod_major,
        ffos_dimensional_by_date.prod_os,
        ffos_dimensional_by_date.v_prod_os,
        ffos_dimensional_by_date.continent_code,
        ffos_dimensional_by_date.cntry_code,
        ffos_dimensional_by_date.isp_name,
        ffos_dimensional_by_date.device_type,
        ffos_dimensional_by_date.tot_request_on_date
 FROM public.ffos_dimensional_by_date
 ORDER BY ffos_dimensional_by_date._year_quarter,
          ffos_dimensional_by_date.date,
          ffos_dimensional_by_date.product,
          ffos_dimensional_by_date.v_prod_major,
          ffos_dimensional_by_date.prod_os,
          ffos_dimensional_by_date.v_prod_os,
          ffos_dimensional_by_date.continent_code,
          ffos_dimensional_by_date.cntry_code,
          ffos_dimensional_by_date.isp_name,
          ffos_dimensional_by_date.device_type,
          ffos_dimensional_by_date.tot_request_on_date
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.f_bugs_snapshot_v2 /*+createtype(L)*/ 
(
 id,
 es_id,
 bug_id,
 bug_severity,
 bug_status,
 bug_version_num,
 assigned_to,
 component,
 created_by,
 created_ts,
 modified_by,
 modified_ts,
 op_sys,
 priority,
 product,
 qa_contact,
 reported_by,
 reporter,
 version,
 expires_on,
 cf_due_date,
 target_milestone,
 short_desc,
 bug_status_resolution,
 keywords,
 snapshot_date
)
AS
 SELECT f_bugs_snapshot_v2.id,
        f_bugs_snapshot_v2.es_id,
        f_bugs_snapshot_v2.bug_id,
        f_bugs_snapshot_v2.bug_severity,
        f_bugs_snapshot_v2.bug_status,
        f_bugs_snapshot_v2.bug_version_num,
        f_bugs_snapshot_v2.assigned_to,
        f_bugs_snapshot_v2.component,
        f_bugs_snapshot_v2.created_by,
        f_bugs_snapshot_v2.created_ts,
        f_bugs_snapshot_v2.modified_by,
        f_bugs_snapshot_v2.modified_ts,
        f_bugs_snapshot_v2.op_sys,
        f_bugs_snapshot_v2.priority,
        f_bugs_snapshot_v2.product,
        f_bugs_snapshot_v2.qa_contact,
        f_bugs_snapshot_v2.reported_by,
        f_bugs_snapshot_v2.reporter,
        f_bugs_snapshot_v2.version,
        f_bugs_snapshot_v2.expires_on,
        f_bugs_snapshot_v2.cf_due_date,
        f_bugs_snapshot_v2.target_milestone,
        f_bugs_snapshot_v2.short_desc,
        f_bugs_snapshot_v2.bug_status_resolution,
        f_bugs_snapshot_v2.keywords,
        f_bugs_snapshot_v2.snapshot_date
 FROM public.f_bugs_snapshot_v2
 ORDER BY f_bugs_snapshot_v2.id,
          f_bugs_snapshot_v2.es_id,
          f_bugs_snapshot_v2.bug_id,
          f_bugs_snapshot_v2.bug_severity,
          f_bugs_snapshot_v2.bug_status,
          f_bugs_snapshot_v2.bug_version_num,
          f_bugs_snapshot_v2.assigned_to,
          f_bugs_snapshot_v2.component,
          f_bugs_snapshot_v2.created_by,
          f_bugs_snapshot_v2.created_ts,
          f_bugs_snapshot_v2.modified_by,
          f_bugs_snapshot_v2.modified_ts,
          f_bugs_snapshot_v2.op_sys,
          f_bugs_snapshot_v2.priority,
          f_bugs_snapshot_v2.product,
          f_bugs_snapshot_v2.qa_contact,
          f_bugs_snapshot_v2.reported_by,
          f_bugs_snapshot_v2.reporter,
          f_bugs_snapshot_v2.version,
          f_bugs_snapshot_v2.expires_on,
          f_bugs_snapshot_v2.cf_due_date,
          f_bugs_snapshot_v2.target_milestone,
          f_bugs_snapshot_v2.short_desc,
          f_bugs_snapshot_v2.bug_status_resolution,
          f_bugs_snapshot_v2.keywords,
          f_bugs_snapshot_v2.snapshot_date
SEGMENTED BY hash(f_bugs_snapshot_v2.id, f_bugs_snapshot_v2.created_ts, f_bugs_snapshot_v2.modified_ts, f_bugs_snapshot_v2.snapshot_date, f_bugs_snapshot_v2.es_id, f_bugs_snapshot_v2.bug_id, f_bugs_snapshot_v2.bug_severity, f_bugs_snapshot_v2.bug_status, f_bugs_snapshot_v2.bug_version_num, f_bugs_snapshot_v2.assigned_to, f_bugs_snapshot_v2.component, f_bugs_snapshot_v2.created_by, f_bugs_snapshot_v2.modified_by, f_bugs_snapshot_v2.op_sys, f_bugs_snapshot_v2.priority, f_bugs_snapshot_v2.product, f_bugs_snapshot_v2.qa_contact, f_bugs_snapshot_v2.reported_by, f_bugs_snapshot_v2.reporter, f_bugs_snapshot_v2.version, f_bugs_snapshot_v2.expires_on, f_bugs_snapshot_v2.cf_due_date, f_bugs_snapshot_v2.target_milestone, f_bugs_snapshot_v2.short_desc, f_bugs_snapshot_v2.bug_status_resolution, f_bugs_snapshot_v2.keywords) ALL NODES KSAFE 1;

CREATE PROJECTION public.f_bugs_status_resolution /*+createtype(L)*/ 
(
 bug_id,
 bug_severity,
 short_desc,
 bug_status,
 bug_status_previous,
 status_update,
 status_change_update,
 curr_snapshot_date
)
AS
 SELECT f_bugs_status_resolution.bug_id,
        f_bugs_status_resolution.bug_severity,
        f_bugs_status_resolution.short_desc,
        f_bugs_status_resolution.bug_status,
        f_bugs_status_resolution.bug_status_previous,
        f_bugs_status_resolution.status_update,
        f_bugs_status_resolution.status_change_update,
        f_bugs_status_resolution.curr_snapshot_date
 FROM public.f_bugs_status_resolution
 ORDER BY f_bugs_status_resolution.status_change_update,
          f_bugs_status_resolution.bug_id
SEGMENTED BY hash(f_bugs_status_resolution.status_change_update, f_bugs_status_resolution.curr_snapshot_date, f_bugs_status_resolution.bug_severity, f_bugs_status_resolution.bug_id, f_bugs_status_resolution.bug_status, f_bugs_status_resolution.bug_status_previous, f_bugs_status_resolution.status_update, f_bugs_status_resolution.short_desc) ALL NODES KSAFE 1;

CREATE PROJECTION public.mozilla_staff /*+createtype(L)*/ 
(
 employee_id,
 first_name,
 last_name,
 email_address,
 supervisory_organization,
 cost_center,
 functional_group,
 manager_id,
 manager_lastname,
 manager_firstname,
 is_manager,
 hire_date,
 location,
 snapshot_date
)
AS
 SELECT mozilla_staff.employee_id,
        mozilla_staff.first_name,
        mozilla_staff.last_name,
        mozilla_staff.email_address,
        mozilla_staff.supervisory_organization,
        mozilla_staff.cost_center,
        mozilla_staff.functional_group,
        mozilla_staff.manager_id,
        mozilla_staff.manager_lastname,
        mozilla_staff.manager_firstname,
        mozilla_staff.is_manager,
        mozilla_staff.hire_date,
        mozilla_staff.location,
        mozilla_staff.snapshot_date
 FROM public.mozilla_staff
 ORDER BY mozilla_staff.employee_id,
          mozilla_staff.first_name,
          mozilla_staff.last_name,
          mozilla_staff.email_address,
          mozilla_staff.supervisory_organization,
          mozilla_staff.cost_center,
          mozilla_staff.functional_group,
          mozilla_staff.manager_id,
          mozilla_staff.manager_lastname,
          mozilla_staff.manager_firstname,
          mozilla_staff.is_manager,
          mozilla_staff.hire_date,
          mozilla_staff.location,
          mozilla_staff.snapshot_date
SEGMENTED BY hash(mozilla_staff.is_manager, mozilla_staff.hire_date, mozilla_staff.snapshot_date, mozilla_staff.employee_id, mozilla_staff.first_name, mozilla_staff.last_name, mozilla_staff.supervisory_organization, mozilla_staff.cost_center, mozilla_staff.functional_group, mozilla_staff.manager_id, mozilla_staff.manager_lastname, mozilla_staff.manager_firstname, mozilla_staff.location, mozilla_staff.email_address) ALL NODES KSAFE 1;

CREATE PROJECTION public.snippet_count_fennec /*+createtype(L)*/ 
(
 utc_time,
 local_time,
 country_code,
 country_name,
 latitude,
 longitude,
 city,
 domain_name,
 org_name,
 isp_name,
 request_type,
 request_url,
 http_status_code,
 response_size_in_bytes,
 referring_url,
 ua_family,
 ua_major,
 ua_minor,
 os_family,
 os_major,
 os_minor,
 device_family,
 custom_field_1,
 custom_field_2,
 custom_field_3,
 filename,
 snippet_id,
 snippet_impression_date
)
AS
 SELECT snippet_count_fennec.utc_time,
        snippet_count_fennec.local_time,
        snippet_count_fennec.country_code,
        snippet_count_fennec.country_name,
        snippet_count_fennec.latitude,
        snippet_count_fennec.longitude,
        snippet_count_fennec.city,
        snippet_count_fennec.domain_name,
        snippet_count_fennec.org_name,
        snippet_count_fennec.isp_name,
        snippet_count_fennec.request_type,
        snippet_count_fennec.request_url,
        snippet_count_fennec.http_status_code,
        snippet_count_fennec.response_size_in_bytes,
        snippet_count_fennec.referring_url,
        snippet_count_fennec.ua_family,
        snippet_count_fennec.ua_major,
        snippet_count_fennec.ua_minor,
        snippet_count_fennec.os_family,
        snippet_count_fennec.os_major,
        snippet_count_fennec.os_minor,
        snippet_count_fennec.device_family,
        snippet_count_fennec.custom_field_1,
        snippet_count_fennec.custom_field_2,
        snippet_count_fennec.custom_field_3,
        snippet_count_fennec.filename,
        snippet_count_fennec.snippet_id,
        snippet_count_fennec.snippet_impression_date
 FROM public.snippet_count_fennec
 ORDER BY snippet_count_fennec.utc_time,
          snippet_count_fennec.local_time,
          snippet_count_fennec.country_code,
          snippet_count_fennec.country_name,
          snippet_count_fennec.latitude,
          snippet_count_fennec.longitude,
          snippet_count_fennec.city,
          snippet_count_fennec.domain_name,
          snippet_count_fennec.org_name,
          snippet_count_fennec.isp_name,
          snippet_count_fennec.request_type,
          snippet_count_fennec.request_url,
          snippet_count_fennec.http_status_code,
          snippet_count_fennec.response_size_in_bytes,
          snippet_count_fennec.referring_url,
          snippet_count_fennec.ua_family,
          snippet_count_fennec.ua_major,
          snippet_count_fennec.ua_minor,
          snippet_count_fennec.os_family,
          snippet_count_fennec.os_major,
          snippet_count_fennec.os_minor,
          snippet_count_fennec.device_family,
          snippet_count_fennec.custom_field_1,
          snippet_count_fennec.custom_field_2,
          snippet_count_fennec.custom_field_3,
          snippet_count_fennec.filename,
          snippet_count_fennec.snippet_id,
          snippet_count_fennec.snippet_impression_date
SEGMENTED BY hash(snippet_count_fennec.snippet_id, snippet_count_fennec.utc_time, snippet_count_fennec.local_time, snippet_count_fennec.country_code, snippet_count_fennec.country_name, snippet_count_fennec.latitude, snippet_count_fennec.longitude, snippet_count_fennec.city, snippet_count_fennec.domain_name, snippet_count_fennec.org_name, snippet_count_fennec.isp_name, snippet_count_fennec.request_type, snippet_count_fennec.request_url, snippet_count_fennec.http_status_code, snippet_count_fennec.response_size_in_bytes, snippet_count_fennec.referring_url, snippet_count_fennec.ua_family, snippet_count_fennec.ua_major, snippet_count_fennec.ua_minor, snippet_count_fennec.os_family, snippet_count_fennec.os_major, snippet_count_fennec.os_minor, snippet_count_fennec.device_family, snippet_count_fennec.custom_field_1, snippet_count_fennec.custom_field_2, snippet_count_fennec.custom_field_3, snippet_count_fennec.filename, snippet_count_fennec.snippet_impression_date) ALL NODES KSAFE 1;

CREATE PROJECTION public.adi_by_date_version_country_locale_channel /*+createtype(L)*/ 
(
 ping_date,
 version,
 country,
 locale,
 release_channel,
 ADI
)
AS
 SELECT adi_firefox_by_date_version_country_locale_channel.ping_date,
        adi_firefox_by_date_version_country_locale_channel.version,
        adi_firefox_by_date_version_country_locale_channel.country,
        adi_firefox_by_date_version_country_locale_channel.locale,
        adi_firefox_by_date_version_country_locale_channel.release_channel,
        adi_firefox_by_date_version_country_locale_channel.ADI
 FROM public.adi_firefox_by_date_version_country_locale_channel
 ORDER BY adi_firefox_by_date_version_country_locale_channel.ping_date,
          adi_firefox_by_date_version_country_locale_channel.country,
          adi_firefox_by_date_version_country_locale_channel.locale,
          adi_firefox_by_date_version_country_locale_channel.version,
          adi_firefox_by_date_version_country_locale_channel.release_channel
SEGMENTED BY hash(adi_firefox_by_date_version_country_locale_channel.ping_date, adi_firefox_by_date_version_country_locale_channel.country, adi_firefox_by_date_version_country_locale_channel.locale, adi_firefox_by_date_version_country_locale_channel.version, adi_firefox_by_date_version_country_locale_channel.release_channel) ALL NODES KSAFE 1;

CREATE PROJECTION public.a_downloads_locale_location_channel /*+createtype(A)*/ 
(
 dates_Year,
 dates_Month,
 dates_Day_of_month,
 dates_Date,
 download_products_Name,
 download_products_Major,
 download_products_Version,
 request_types_Type,
 download_types_Type,
 request_result_Result,
 locales_Code,
 locations_Continent_name,
 locations_Country_name,
 download_products_rebuild_Name,
 download_products_rebuild_Channel,
 download_requests_by_day_Total_Requests,
 download_requests_by_day_fact_count
)
AS
 SELECT a_downloads_locale_location_channel.dates_Year,
        a_downloads_locale_location_channel.dates_Month,
        a_downloads_locale_location_channel.dates_Day_of_month,
        a_downloads_locale_location_channel.dates_Date,
        a_downloads_locale_location_channel.download_products_Name,
        a_downloads_locale_location_channel.download_products_Major,
        a_downloads_locale_location_channel.download_products_Version,
        a_downloads_locale_location_channel.request_types_Type,
        a_downloads_locale_location_channel.download_types_Type,
        a_downloads_locale_location_channel.request_result_Result,
        a_downloads_locale_location_channel.locales_Code,
        a_downloads_locale_location_channel.locations_Continent_name,
        a_downloads_locale_location_channel.locations_Country_name,
        a_downloads_locale_location_channel.download_products_rebuild_Name,
        a_downloads_locale_location_channel.download_products_rebuild_Channel,
        a_downloads_locale_location_channel.download_requests_by_day_Total_Requests,
        a_downloads_locale_location_channel.download_requests_by_day_fact_count
 FROM public.a_downloads_locale_location_channel
 ORDER BY a_downloads_locale_location_channel.dates_Year,
          a_downloads_locale_location_channel.dates_Month,
          a_downloads_locale_location_channel.dates_Day_of_month,
          a_downloads_locale_location_channel.dates_Date,
          a_downloads_locale_location_channel.download_products_Name,
          a_downloads_locale_location_channel.request_types_Type,
          a_downloads_locale_location_channel.download_types_Type,
          a_downloads_locale_location_channel.request_result_Result,
          a_downloads_locale_location_channel.locations_Continent_name,
          a_downloads_locale_location_channel.locations_Country_name,
          a_downloads_locale_location_channel.download_products_rebuild_Channel
SEGMENTED BY hash(a_downloads_locale_location_channel.download_requests_by_day_Total_Requests) ALL NODES KSAFE 1;

CREATE PROJECTION public.foo /*+createtype(A)*/ 
(
 is_released,
 version_int,
 version,
 channel,
 merge_date,
 release_date,
 product
)
AS
 SELECT releases.is_released,
        releases.version_int,
        releases.version,
        releases.channel,
        releases.merge_date,
        releases.release_date,
        releases.product
 FROM public.releases
 ORDER BY releases.is_released,
          releases.version_int
SEGMENTED BY hash(releases.is_released, releases.version_int, releases.version, releases.merge_date, releases.release_date, releases.channel, releases.product) ALL NODES KSAFE 1;

CREATE PROJECTION public.adi_by_region /*+createtype(L)*/ 
(
 yr,
 mnth,
 region,
 country_code,
 domain,
 tot_requests,
 product
)
AS
 SELECT adi_by_region.yr,
        adi_by_region.mnth,
        adi_by_region.region,
        adi_by_region.country_code,
        adi_by_region.domain,
        adi_by_region.tot_requests,
        adi_by_region.product
 FROM public.adi_by_region
 ORDER BY adi_by_region.yr,
          adi_by_region.mnth,
          adi_by_region.region,
          adi_by_region.country_code,
          adi_by_region.domain,
          adi_by_region.product
SEGMENTED BY hash(adi_by_region.yr, adi_by_region.mnth, adi_by_region.region, adi_by_region.country_code, adi_by_region.domain, adi_by_region.product) ALL NODES KSAFE 1;

CREATE PROJECTION public.nagios_log_data /*+createtype(L)*/ 
(
 event_occurred_at,
 incident_type,
 host,
 service,
 status,
 notify_by,
 description,
 filename
)
AS
 SELECT nagios_log_data.event_occurred_at,
        nagios_log_data.incident_type,
        nagios_log_data.host,
        nagios_log_data.service,
        nagios_log_data.status,
        nagios_log_data.notify_by,
        nagios_log_data.description,
        nagios_log_data.filename
 FROM public.nagios_log_data
 ORDER BY nagios_log_data.event_occurred_at,
          nagios_log_data.incident_type,
          nagios_log_data.host,
          nagios_log_data.service,
          nagios_log_data.status,
          nagios_log_data.notify_by,
          nagios_log_data.description
SEGMENTED BY hash(nagios_log_data.event_occurred_at, nagios_log_data.status, nagios_log_data.incident_type, nagios_log_data.host, nagios_log_data.service, nagios_log_data.notify_by, nagios_log_data.description) ALL NODES KSAFE 1;

CREATE PROJECTION public.snippet_count_20151104 /*+createtype(L)*/ 
(
 date,
 ua_family,
 ua_major,
 os_family,
 country_code,
 snippet_id,
 impression_count,
 locale,
 metric,
 user_country,
 campaign
)
AS
 SELECT snippet_count_20151104.date,
        snippet_count_20151104.ua_family,
        snippet_count_20151104.ua_major,
        snippet_count_20151104.os_family,
        snippet_count_20151104.country_code,
        snippet_count_20151104.snippet_id,
        snippet_count_20151104.impression_count,
        snippet_count_20151104.locale,
        snippet_count_20151104.metric,
        snippet_count_20151104.user_country,
        snippet_count_20151104.campaign
 FROM public.snippet_count_20151104
 ORDER BY snippet_count_20151104.date,
          snippet_count_20151104.ua_family,
          snippet_count_20151104.ua_major,
          snippet_count_20151104.os_family,
          snippet_count_20151104.country_code,
          snippet_count_20151104.snippet_id,
          snippet_count_20151104.impression_count,
          snippet_count_20151104.locale,
          snippet_count_20151104.metric
SEGMENTED BY hash(snippet_count_20151104.date, snippet_count_20151104.ua_major, snippet_count_20151104.country_code, snippet_count_20151104.impression_count, snippet_count_20151104.user_country, snippet_count_20151104.ua_family, snippet_count_20151104.os_family, snippet_count_20151104.snippet_id, snippet_count_20151104.locale, snippet_count_20151104.metric, snippet_count_20151104.campaign) ALL NODES KSAFE 1;

CREATE PROJECTION public.snippet_count_fennec_20151104 /*+createtype(L)*/ 
(
 utc_time,
 local_time,
 country_code,
 country_name,
 latitude,
 longitude,
 city,
 domain_name,
 org_name,
 isp_name,
 request_type,
 request_url,
 http_status_code,
 response_size_in_bytes,
 referring_url,
 ua_family,
 ua_major,
 ua_minor,
 os_family,
 os_major,
 os_minor,
 device_family,
 custom_field_1,
 custom_field_2,
 custom_field_3,
 filename,
 snippet_id,
 snippet_impression_date
)
AS
 SELECT snippet_count_fennec_20151104.utc_time,
        snippet_count_fennec_20151104.local_time,
        snippet_count_fennec_20151104.country_code,
        snippet_count_fennec_20151104.country_name,
        snippet_count_fennec_20151104.latitude,
        snippet_count_fennec_20151104.longitude,
        snippet_count_fennec_20151104.city,
        snippet_count_fennec_20151104.domain_name,
        snippet_count_fennec_20151104.org_name,
        snippet_count_fennec_20151104.isp_name,
        snippet_count_fennec_20151104.request_type,
        snippet_count_fennec_20151104.request_url,
        snippet_count_fennec_20151104.http_status_code,
        snippet_count_fennec_20151104.response_size_in_bytes,
        snippet_count_fennec_20151104.referring_url,
        snippet_count_fennec_20151104.ua_family,
        snippet_count_fennec_20151104.ua_major,
        snippet_count_fennec_20151104.ua_minor,
        snippet_count_fennec_20151104.os_family,
        snippet_count_fennec_20151104.os_major,
        snippet_count_fennec_20151104.os_minor,
        snippet_count_fennec_20151104.device_family,
        snippet_count_fennec_20151104.custom_field_1,
        snippet_count_fennec_20151104.custom_field_2,
        snippet_count_fennec_20151104.custom_field_3,
        snippet_count_fennec_20151104.filename,
        snippet_count_fennec_20151104.snippet_id,
        snippet_count_fennec_20151104.snippet_impression_date
 FROM public.snippet_count_fennec_20151104
 ORDER BY snippet_count_fennec_20151104.utc_time,
          snippet_count_fennec_20151104.local_time,
          snippet_count_fennec_20151104.country_code,
          snippet_count_fennec_20151104.country_name,
          snippet_count_fennec_20151104.latitude,
          snippet_count_fennec_20151104.longitude,
          snippet_count_fennec_20151104.city,
          snippet_count_fennec_20151104.domain_name,
          snippet_count_fennec_20151104.org_name,
          snippet_count_fennec_20151104.isp_name,
          snippet_count_fennec_20151104.request_type,
          snippet_count_fennec_20151104.request_url,
          snippet_count_fennec_20151104.http_status_code,
          snippet_count_fennec_20151104.response_size_in_bytes,
          snippet_count_fennec_20151104.referring_url,
          snippet_count_fennec_20151104.ua_family,
          snippet_count_fennec_20151104.ua_major,
          snippet_count_fennec_20151104.ua_minor,
          snippet_count_fennec_20151104.os_family,
          snippet_count_fennec_20151104.os_major,
          snippet_count_fennec_20151104.os_minor,
          snippet_count_fennec_20151104.device_family,
          snippet_count_fennec_20151104.custom_field_1,
          snippet_count_fennec_20151104.custom_field_2,
          snippet_count_fennec_20151104.custom_field_3,
          snippet_count_fennec_20151104.filename,
          snippet_count_fennec_20151104.snippet_id,
          snippet_count_fennec_20151104.snippet_impression_date
SEGMENTED BY hash(snippet_count_fennec_20151104.snippet_id, snippet_count_fennec_20151104.utc_time, snippet_count_fennec_20151104.local_time, snippet_count_fennec_20151104.country_code, snippet_count_fennec_20151104.country_name, snippet_count_fennec_20151104.latitude, snippet_count_fennec_20151104.longitude, snippet_count_fennec_20151104.city, snippet_count_fennec_20151104.domain_name, snippet_count_fennec_20151104.org_name, snippet_count_fennec_20151104.isp_name, snippet_count_fennec_20151104.request_type, snippet_count_fennec_20151104.request_url, snippet_count_fennec_20151104.http_status_code, snippet_count_fennec_20151104.response_size_in_bytes, snippet_count_fennec_20151104.referring_url, snippet_count_fennec_20151104.ua_family, snippet_count_fennec_20151104.ua_major, snippet_count_fennec_20151104.ua_minor, snippet_count_fennec_20151104.os_family, snippet_count_fennec_20151104.os_major, snippet_count_fennec_20151104.os_minor, snippet_count_fennec_20151104.device_family, snippet_count_fennec_20151104.custom_field_1, snippet_count_fennec_20151104.custom_field_2, snippet_count_fennec_20151104.custom_field_3, snippet_count_fennec_20151104.filename, snippet_count_fennec_20151104.snippet_impression_date) ALL NODES KSAFE 1;

CREATE PROJECTION public.vertica_backups /*+createtype(L)*/ 
(
 backupDate,
 sizeBytes,
 node,
 status,
 snapshotDate
)
AS
 SELECT vertica_backups.backupDate,
        vertica_backups.sizeBytes,
        vertica_backups.node,
        vertica_backups.status,
        vertica_backups.snapshotDate
 FROM public.vertica_backups
 ORDER BY vertica_backups.backupDate,
          vertica_backups.sizeBytes,
          vertica_backups.node,
          vertica_backups.status
SEGMENTED BY hash(vertica_backups.backupDate, vertica_backups.sizeBytes, vertica_backups.status, vertica_backups.node) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_monthly_rollups /*+createtype(L)*/ 
(
 month,
 search_provider,
 search_count,
 country,
 locale,
 distribution_id,
 default_provider,
 profiles_matching,
 processed
)
AS
 SELECT ut_monthly_rollups_old.month,
        ut_monthly_rollups_old.search_provider,
        ut_monthly_rollups_old.search_count,
        ut_monthly_rollups_old.country,
        ut_monthly_rollups_old.locale,
        ut_monthly_rollups_old.distribution_id,
        ut_monthly_rollups_old.default_provider,
        ut_monthly_rollups_old.profiles_matching,
        ut_monthly_rollups_old.processed
 FROM public.ut_monthly_rollups_old
 ORDER BY ut_monthly_rollups_old.month,
          ut_monthly_rollups_old.search_provider,
          ut_monthly_rollups_old.search_count,
          ut_monthly_rollups_old.country,
          ut_monthly_rollups_old.locale,
          ut_monthly_rollups_old.distribution_id,
          ut_monthly_rollups_old.default_provider,
          ut_monthly_rollups_old.profiles_matching,
          ut_monthly_rollups_old.processed
SEGMENTED BY hash(ut_monthly_rollups_old.month, ut_monthly_rollups_old.search_count, ut_monthly_rollups_old.profiles_matching, ut_monthly_rollups_old.processed, ut_monthly_rollups_old.search_provider, ut_monthly_rollups_old.country, ut_monthly_rollups_old.locale, ut_monthly_rollups_old.distribution_id, ut_monthly_rollups_old.default_provider) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_monthly_2 /*+createtype(L)*/ 
(
 month,
 search_provider,
 search_count,
 country,
 locale,
 distribution_id,
 default_provider,
 profiles_matching,
 processed
)
AS
 SELECT ut_monthly_rollups.month,
        ut_monthly_rollups.search_provider,
        ut_monthly_rollups.search_count,
        ut_monthly_rollups.country,
        ut_monthly_rollups.locale,
        ut_monthly_rollups.distribution_id,
        ut_monthly_rollups.default_provider,
        ut_monthly_rollups.profiles_matching,
        ut_monthly_rollups.processed
 FROM public.ut_monthly_rollups
 ORDER BY ut_monthly_rollups.month,
          ut_monthly_rollups.search_provider,
          ut_monthly_rollups.search_count,
          ut_monthly_rollups.country,
          ut_monthly_rollups.locale,
          ut_monthly_rollups.distribution_id,
          ut_monthly_rollups.default_provider,
          ut_monthly_rollups.profiles_matching,
          ut_monthly_rollups.processed
SEGMENTED BY hash(ut_monthly_rollups.month, ut_monthly_rollups.search_count, ut_monthly_rollups.profiles_matching, ut_monthly_rollups.processed, ut_monthly_rollups.search_provider, ut_monthly_rollups.country, ut_monthly_rollups.locale, ut_monthly_rollups.distribution_id, ut_monthly_rollups.default_provider) ALL NODES KSAFE 1;

CREATE PROJECTION public.search_cohort /*+createtype(L)*/ 
(
 channel,
 geo,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 current_week,
 is_active,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours
)
AS
 SELECT search_cohort.channel,
        search_cohort.geo,
        search_cohort.is_funnelcake,
        search_cohort.acquisition_period,
        search_cohort.start_version,
        search_cohort.sync_usage,
        search_cohort.current_version,
        search_cohort.current_week,
        search_cohort.is_active,
        search_cohort.n_profiles,
        search_cohort.usage_hours,
        search_cohort.sum_squared_usage_hours
 FROM public.search_cohort
 ORDER BY search_cohort.channel,
          search_cohort.geo,
          search_cohort.is_funnelcake,
          search_cohort.acquisition_period,
          search_cohort.start_version,
          search_cohort.sync_usage,
          search_cohort.current_version,
          search_cohort.current_week,
          search_cohort.is_active,
          search_cohort.n_profiles,
          search_cohort.usage_hours,
          search_cohort.sum_squared_usage_hours
SEGMENTED BY hash(search_cohort.geo, search_cohort.is_funnelcake, search_cohort.acquisition_period, search_cohort.current_week, search_cohort.is_active, search_cohort.n_profiles, search_cohort.usage_hours, search_cohort.sum_squared_usage_hours, search_cohort.start_version, search_cohort.sync_usage, search_cohort.current_version, search_cohort.channel) ALL NODES KSAFE 1;

CREATE PROJECTION public.fx_desktop_er /*+createtype(L)*/ 
(
 activity_date,
 mau,
 dau,
 smooth_dau,
 er
)
AS
 SELECT fx_desktop_er.activity_date,
        fx_desktop_er.mau,
        fx_desktop_er.dau,
        fx_desktop_er.smooth_dau,
        fx_desktop_er.er
 FROM public.fx_desktop_er
 ORDER BY fx_desktop_er.activity_date,
          fx_desktop_er.mau,
          fx_desktop_er.dau,
          fx_desktop_er.smooth_dau,
          fx_desktop_er.er
SEGMENTED BY hash(fx_desktop_er.activity_date, fx_desktop_er.mau, fx_desktop_er.dau, fx_desktop_er.smooth_dau, fx_desktop_er.er) ALL NODES KSAFE 1;

CREATE PROJECTION public.brain_juicer /*+createtype(L)*/ 
(
 month_year,
 country,
 sample_size,
 brand,
 uba_as_io,
 uba_as_browser,
 mozilla_bpi,
 non_profit_cc,
 opinionated_cc,
 innovative_cc,
 inclusive_cc,
 firefox_bpi,
 independent,
 trustworty,
 non_profit,
 empowering,
 aware_health_of_internet,
 aware_online_priv_sec,
 aware_open_innovation,
 aware_decentralization,
 aware_web_literacy,
 aware_digital_inclusion,
 care_online_priv_sec,
 care_open_innovation,
 care_decentralization,
 care_web_literacy,
 care_inclusion
)
AS
 SELECT brain_juicer.month_year,
        brain_juicer.country,
        brain_juicer.sample_size,
        brain_juicer.brand,
        brain_juicer.uba_as_io,
        brain_juicer.uba_as_browser,
        brain_juicer.mozilla_bpi,
        brain_juicer.non_profit_cc,
        brain_juicer.opinionated_cc,
        brain_juicer.innovative_cc,
        brain_juicer.inclusive_cc,
        brain_juicer.firefox_bpi,
        brain_juicer.independent,
        brain_juicer.trustworty,
        brain_juicer.non_profit,
        brain_juicer.empowering,
        brain_juicer.aware_health_of_internet,
        brain_juicer.aware_online_priv_sec,
        brain_juicer.aware_open_innovation,
        brain_juicer.aware_decentralization,
        brain_juicer.aware_web_literacy,
        brain_juicer.aware_digital_inclusion,
        brain_juicer.care_online_priv_sec,
        brain_juicer.care_open_innovation,
        brain_juicer.care_decentralization,
        brain_juicer.care_web_literacy,
        brain_juicer.care_inclusion
 FROM public.brain_juicer
 ORDER BY brain_juicer.month_year,
          brain_juicer.country,
          brain_juicer.sample_size,
          brain_juicer.brand,
          brain_juicer.uba_as_io,
          brain_juicer.uba_as_browser,
          brain_juicer.mozilla_bpi,
          brain_juicer.non_profit_cc,
          brain_juicer.opinionated_cc,
          brain_juicer.innovative_cc,
          brain_juicer.inclusive_cc,
          brain_juicer.firefox_bpi,
          brain_juicer.independent,
          brain_juicer.trustworty,
          brain_juicer.non_profit,
          brain_juicer.empowering,
          brain_juicer.aware_health_of_internet,
          brain_juicer.aware_online_priv_sec,
          brain_juicer.aware_open_innovation,
          brain_juicer.aware_decentralization,
          brain_juicer.aware_web_literacy,
          brain_juicer.aware_digital_inclusion,
          brain_juicer.care_online_priv_sec,
          brain_juicer.care_open_innovation,
          brain_juicer.care_decentralization,
          brain_juicer.care_web_literacy,
          brain_juicer.care_inclusion
SEGMENTED BY hash(brain_juicer.month_year, brain_juicer.sample_size, brain_juicer.uba_as_io, brain_juicer.uba_as_browser, brain_juicer.mozilla_bpi, brain_juicer.non_profit_cc, brain_juicer.opinionated_cc, brain_juicer.innovative_cc, brain_juicer.inclusive_cc, brain_juicer.firefox_bpi, brain_juicer.independent, brain_juicer.trustworty, brain_juicer.non_profit, brain_juicer.empowering, brain_juicer.aware_health_of_internet, brain_juicer.aware_online_priv_sec, brain_juicer.aware_open_innovation, brain_juicer.aware_decentralization, brain_juicer.aware_web_literacy, brain_juicer.aware_digital_inclusion, brain_juicer.care_online_priv_sec, brain_juicer.care_open_innovation, brain_juicer.care_decentralization, brain_juicer.care_web_literacy, brain_juicer.care_inclusion, brain_juicer.brand, brain_juicer.country) ALL NODES KSAFE 1;

CREATE PROJECTION public.statcounter /*+createtype(L)*/ 
(
 st_date,
 browser,
 stat,
 region,
 device
)
AS
 SELECT statcounter.st_date,
        statcounter.browser,
        statcounter.stat,
        statcounter.region,
        statcounter.device
 FROM public.statcounter
 ORDER BY statcounter.st_date,
          statcounter.browser,
          statcounter.stat,
          statcounter.region,
          statcounter.device
SEGMENTED BY hash(statcounter.st_date, statcounter.stat, statcounter.device, statcounter.region, statcounter.browser) ALL NODES KSAFE 1;

CREATE PROJECTION public.v4_monthly /*+createtype(L)*/ 
(
 geo,
 channel,
 os,
 v4_date,
 actives,
 hours,
 inactives,
 new_records,
 five_of_seven,
 total_records,
 crashes,
 v4_default,
 google,
 bing,
 yahoo,
 other
)
AS
 SELECT v4_monthly.geo,
        v4_monthly.channel,
        v4_monthly.os,
        v4_monthly.v4_date,
        v4_monthly.actives,
        v4_monthly.hours,
        v4_monthly.inactives,
        v4_monthly.new_records,
        v4_monthly.five_of_seven,
        v4_monthly.total_records,
        v4_monthly.crashes,
        v4_monthly.v4_default,
        v4_monthly.google,
        v4_monthly.bing,
        v4_monthly.yahoo,
        v4_monthly.other
 FROM public.v4_monthly
 ORDER BY v4_monthly.geo,
          v4_monthly.channel,
          v4_monthly.os,
          v4_monthly.v4_date,
          v4_monthly.actives,
          v4_monthly.hours,
          v4_monthly.inactives,
          v4_monthly.new_records,
          v4_monthly.five_of_seven,
          v4_monthly.total_records,
          v4_monthly.crashes,
          v4_monthly.v4_default,
          v4_monthly.google,
          v4_monthly.bing,
          v4_monthly.yahoo,
          v4_monthly.other
SEGMENTED BY hash(v4_monthly.v4_date, v4_monthly.actives, v4_monthly.hours, v4_monthly.inactives, v4_monthly.new_records, v4_monthly.five_of_seven, v4_monthly.total_records, v4_monthly.crashes, v4_monthly.v4_default, v4_monthly.google, v4_monthly.bing, v4_monthly.yahoo, v4_monthly.other, v4_monthly.geo, v4_monthly.channel, v4_monthly.os) ALL NODES KSAFE 1;

CREATE PROJECTION public.blocklistDecomposition /*+createtype(L)*/ 
(
 bd_date,
 dayNum,
 dayOfWeek,
 yearFreq,
 adi,
 trend,
 seasonal,
 weekly,
 outlier,
 noise
)
AS
 SELECT blocklistDecomposition.bd_date,
        blocklistDecomposition.dayNum,
        blocklistDecomposition.dayOfWeek,
        blocklistDecomposition.yearFreq,
        blocklistDecomposition.adi,
        blocklistDecomposition.trend,
        blocklistDecomposition.seasonal,
        blocklistDecomposition.weekly,
        blocklistDecomposition.outlier,
        blocklistDecomposition.noise
 FROM public.blocklistDecomposition
 ORDER BY blocklistDecomposition.bd_date,
          blocklistDecomposition.dayNum,
          blocklistDecomposition.dayOfWeek,
          blocklistDecomposition.yearFreq,
          blocklistDecomposition.adi,
          blocklistDecomposition.trend,
          blocklistDecomposition.seasonal,
          blocklistDecomposition.weekly,
          blocklistDecomposition.outlier,
          blocklistDecomposition.noise
SEGMENTED BY hash(blocklistDecomposition.bd_date, blocklistDecomposition.dayNum, blocklistDecomposition.yearFreq, blocklistDecomposition.adi, blocklistDecomposition.trend, blocklistDecomposition.seasonal, blocklistDecomposition.weekly, blocklistDecomposition.outlier, blocklistDecomposition.noise, blocklistDecomposition.dayOfWeek) ALL NODES KSAFE 1;

CREATE PROJECTION public.engagement_ratio /*+createtype(L)*/ 
(
 day,
 dau,
 mau,
 generated_on
)
AS
 SELECT engagement_ratio.day,
        engagement_ratio.dau,
        engagement_ratio.mau,
        engagement_ratio.generated_on
 FROM public.engagement_ratio
 ORDER BY engagement_ratio.day,
          engagement_ratio.dau,
          engagement_ratio.mau,
          engagement_ratio.generated_on
SEGMENTED BY hash(engagement_ratio.day, engagement_ratio.dau, engagement_ratio.mau, engagement_ratio.generated_on) ALL NODES KSAFE 1;

CREATE PROJECTION public.fx_adjust_mobile /*+createtype(L)*/ 
(
 fx_date,
 maus,
 daus
)
AS
 SELECT fx_adjust_mobile.fx_date,
        fx_adjust_mobile.maus,
        fx_adjust_mobile.daus
 FROM public.fx_adjust_mobile
 ORDER BY fx_adjust_mobile.fx_date,
          fx_adjust_mobile.maus,
          fx_adjust_mobile.daus
SEGMENTED BY hash(fx_adjust_mobile.fx_date, fx_adjust_mobile.maus, fx_adjust_mobile.daus) ALL NODES KSAFE 1;

CREATE PROJECTION public.search_cohort_churn_test /*+createtype(L)*/ 
(
 channel,
 geo,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 current_week,
 source,
 medium,
 campaign,
 content,
 distribution_id,
 default_search_engine,
 locale,
 is_active,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours,
 week_start
)
AS
 SELECT search_cohort_churn_test.channel,
        search_cohort_churn_test.geo,
        search_cohort_churn_test.is_funnelcake,
        search_cohort_churn_test.acquisition_period,
        search_cohort_churn_test.start_version,
        search_cohort_churn_test.sync_usage,
        search_cohort_churn_test.current_version,
        search_cohort_churn_test.current_week,
        search_cohort_churn_test.source,
        search_cohort_churn_test.medium,
        search_cohort_churn_test.campaign,
        search_cohort_churn_test.content,
        search_cohort_churn_test.distribution_id,
        search_cohort_churn_test.default_search_engine,
        search_cohort_churn_test.locale,
        search_cohort_churn_test.is_active,
        search_cohort_churn_test.n_profiles,
        search_cohort_churn_test.usage_hours,
        search_cohort_churn_test.sum_squared_usage_hours,
        search_cohort_churn_test.week_start
 FROM public.search_cohort_churn_test
 ORDER BY search_cohort_churn_test.channel,
          search_cohort_churn_test.geo,
          search_cohort_churn_test.is_funnelcake,
          search_cohort_churn_test.acquisition_period,
          search_cohort_churn_test.start_version,
          search_cohort_churn_test.sync_usage,
          search_cohort_churn_test.current_version,
          search_cohort_churn_test.current_week,
          search_cohort_churn_test.source,
          search_cohort_churn_test.medium,
          search_cohort_churn_test.campaign,
          search_cohort_churn_test.content,
          search_cohort_churn_test.distribution_id,
          search_cohort_churn_test.default_search_engine,
          search_cohort_churn_test.locale,
          search_cohort_churn_test.is_active,
          search_cohort_churn_test.n_profiles,
          search_cohort_churn_test.usage_hours,
          search_cohort_churn_test.sum_squared_usage_hours,
          search_cohort_churn_test.week_start
SEGMENTED BY hash(search_cohort_churn_test.geo, search_cohort_churn_test.is_funnelcake, search_cohort_churn_test.acquisition_period, search_cohort_churn_test.current_week, search_cohort_churn_test.is_active, search_cohort_churn_test.n_profiles, search_cohort_churn_test.usage_hours, search_cohort_churn_test.sum_squared_usage_hours, search_cohort_churn_test.week_start, search_cohort_churn_test.start_version, search_cohort_churn_test.sync_usage, search_cohort_churn_test.current_version, search_cohort_churn_test.locale, search_cohort_churn_test.channel, search_cohort_churn_test.source, search_cohort_churn_test.medium, search_cohort_churn_test.campaign, search_cohort_churn_test.content, search_cohort_churn_test.distribution_id, search_cohort_churn_test.default_search_engine) ALL NODES KSAFE 1;

CREATE PROJECTION public.search_cohort_churn /*+createtype(L)*/ 
(
 channel,
 geo,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 current_week,
 source,
 medium,
 campaign,
 content,
 distribution_id,
 default_search_engine,
 locale,
 is_active,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours,
 week_start
)
AS
 SELECT search_cohort_churn_tmp.channel,
        search_cohort_churn_tmp.geo,
        search_cohort_churn_tmp.is_funnelcake,
        search_cohort_churn_tmp.acquisition_period,
        search_cohort_churn_tmp.start_version,
        search_cohort_churn_tmp.sync_usage,
        search_cohort_churn_tmp.current_version,
        search_cohort_churn_tmp.current_week,
        search_cohort_churn_tmp.source,
        search_cohort_churn_tmp.medium,
        search_cohort_churn_tmp.campaign,
        search_cohort_churn_tmp.content,
        search_cohort_churn_tmp.distribution_id,
        search_cohort_churn_tmp.default_search_engine,
        search_cohort_churn_tmp.locale,
        search_cohort_churn_tmp.is_active,
        search_cohort_churn_tmp.n_profiles,
        search_cohort_churn_tmp.usage_hours,
        search_cohort_churn_tmp.sum_squared_usage_hours,
        search_cohort_churn_tmp.week_start
 FROM public.search_cohort_churn_tmp
 ORDER BY search_cohort_churn_tmp.channel,
          search_cohort_churn_tmp.geo,
          search_cohort_churn_tmp.is_funnelcake,
          search_cohort_churn_tmp.acquisition_period,
          search_cohort_churn_tmp.start_version,
          search_cohort_churn_tmp.sync_usage,
          search_cohort_churn_tmp.current_version,
          search_cohort_churn_tmp.current_week,
          search_cohort_churn_tmp.source,
          search_cohort_churn_tmp.medium,
          search_cohort_churn_tmp.campaign,
          search_cohort_churn_tmp.content,
          search_cohort_churn_tmp.distribution_id,
          search_cohort_churn_tmp.default_search_engine,
          search_cohort_churn_tmp.locale,
          search_cohort_churn_tmp.is_active,
          search_cohort_churn_tmp.n_profiles,
          search_cohort_churn_tmp.usage_hours,
          search_cohort_churn_tmp.sum_squared_usage_hours,
          search_cohort_churn_tmp.week_start
SEGMENTED BY hash(search_cohort_churn_tmp.geo, search_cohort_churn_tmp.is_funnelcake, search_cohort_churn_tmp.acquisition_period, search_cohort_churn_tmp.current_week, search_cohort_churn_tmp.is_active, search_cohort_churn_tmp.n_profiles, search_cohort_churn_tmp.usage_hours, search_cohort_churn_tmp.sum_squared_usage_hours, search_cohort_churn_tmp.week_start, search_cohort_churn_tmp.start_version, search_cohort_churn_tmp.sync_usage, search_cohort_churn_tmp.current_version, search_cohort_churn_tmp.locale, search_cohort_churn_tmp.channel, search_cohort_churn_tmp.source, search_cohort_churn_tmp.medium, search_cohort_churn_tmp.campaign, search_cohort_churn_tmp.content, search_cohort_churn_tmp.distribution_id, search_cohort_churn_tmp.default_search_engine) ALL NODES KSAFE 1;

CREATE PROJECTION public.mysql_host /*+createtype(L)*/ 
(
 id,
 name
)
AS
 SELECT mysql_host.id,
        mysql_host.name
 FROM public.mysql_host
 ORDER BY mysql_host.id
SEGMENTED BY hash(mysql_host.id) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_ios_monthly /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus
)
AS
 SELECT adjust_ios_monthly.adj_date,
        adjust_ios_monthly.daus,
        adjust_ios_monthly.waus,
        adjust_ios_monthly.maus
 FROM public.adjust_ios_monthly
 ORDER BY adjust_ios_monthly.adj_date,
          adjust_ios_monthly.daus,
          adjust_ios_monthly.waus,
          adjust_ios_monthly.maus
SEGMENTED BY hash(adjust_ios_monthly.adj_date, adjust_ios_monthly.daus, adjust_ios_monthly.waus, adjust_ios_monthly.maus) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_android_monthly /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus
)
AS
 SELECT adjust_android_monthly.adj_date,
        adjust_android_monthly.daus,
        adjust_android_monthly.waus,
        adjust_android_monthly.maus
 FROM public.adjust_android_monthly
 ORDER BY adjust_android_monthly.adj_date,
          adjust_android_monthly.daus,
          adjust_android_monthly.waus,
          adjust_android_monthly.maus
SEGMENTED BY hash(adjust_android_monthly.adj_date, adjust_android_monthly.daus, adjust_android_monthly.waus, adjust_android_monthly.maus) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_focus_monthly /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus,
 installs
)
AS
 SELECT adjust_focus_monthly.adj_date,
        adjust_focus_monthly.daus,
        adjust_focus_monthly.waus,
        adjust_focus_monthly.maus,
        adjust_focus_monthly.installs
 FROM public.adjust_focus_monthly
 ORDER BY adjust_focus_monthly.adj_date,
          adjust_focus_monthly.daus,
          adjust_focus_monthly.waus,
          adjust_focus_monthly.maus,
          adjust_focus_monthly.installs
SEGMENTED BY hash(adjust_focus_monthly.adj_date, adjust_focus_monthly.daus, adjust_focus_monthly.waus, adjust_focus_monthly.maus, adjust_focus_monthly.installs) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_klar_monthly /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus,
 installs
)
AS
 SELECT adjust_klar_monthly.adj_date,
        adjust_klar_monthly.daus,
        adjust_klar_monthly.waus,
        adjust_klar_monthly.maus,
        adjust_klar_monthly.installs
 FROM public.adjust_klar_monthly
 ORDER BY adjust_klar_monthly.adj_date,
          adjust_klar_monthly.daus,
          adjust_klar_monthly.waus,
          adjust_klar_monthly.maus,
          adjust_klar_monthly.installs
SEGMENTED BY hash(adjust_klar_monthly.adj_date, adjust_klar_monthly.daus, adjust_klar_monthly.waus, adjust_klar_monthly.maus, adjust_klar_monthly.installs) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc /*+createtype(L)*/ 
(
 sf_date,
 email_program,
 first_run_source,
 country,
 language,
 metric,
 value
)
AS
 SELECT sfmcold.sf_date,
        sfmcold.email_program,
        sfmcold.first_run_source,
        sfmcold.country,
        sfmcold.language,
        sfmcold.metric,
        sfmcold.value
 FROM public.sfmcold
 ORDER BY sfmcold.sf_date,
          sfmcold.email_program,
          sfmcold.first_run_source,
          sfmcold.country,
          sfmcold.language,
          sfmcold.metric,
          sfmcold.value
SEGMENTED BY hash(sfmcold.sf_date, sfmcold.first_run_source, sfmcold.language, sfmcold.value, sfmcold.email_program, sfmcold.country, sfmcold.metric) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_base /*+createtype(L)*/ 
(
 id,
 sf_date,
 email_program,
 first_run_source,
 country,
 language,
 metric,
 value
)
AS
 SELECT sfmcold_base.id,
        sfmcold_base.sf_date,
        sfmcold_base.email_program,
        sfmcold_base.first_run_source,
        sfmcold_base.country,
        sfmcold_base.language,
        sfmcold_base.metric,
        sfmcold_base.value
 FROM public.sfmcold_base
 ORDER BY sfmcold_base.sf_date,
          sfmcold_base.email_program,
          sfmcold_base.first_run_source,
          sfmcold_base.country,
          sfmcold_base.language,
          sfmcold_base.metric,
          sfmcold_base.value
SEGMENTED BY hash(sfmcold_base.sf_date, sfmcold_base.first_run_source, sfmcold_base.language, sfmcold_base.value, sfmcold_base.email_program, sfmcold_base.country, sfmcold_base.metric) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_opens /*+createtype(L)*/ 
(
 id,
 value
)
AS
 SELECT sfmcold_opens.id,
        sfmcold_opens.value
 FROM public.sfmcold_opens
 ORDER BY sfmcold_opens.id,
          sfmcold_opens.value
SEGMENTED BY hash(sfmcold_opens.id, sfmcold_opens.value) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_emails_sent_html /*+createtype(L)*/ 
(
 id,
 value
)
AS
 SELECT sfmcold_emails_sent_html.id,
        sfmcold_emails_sent_html.value
 FROM public.sfmcold_emails_sent_html
 ORDER BY sfmcold_emails_sent_html.id,
          sfmcold_emails_sent_html.value
SEGMENTED BY hash(sfmcold_emails_sent_html.id, sfmcold_emails_sent_html.value) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_emails_sent /*+createtype(L)*/ 
(
 id,
 value
)
AS
 SELECT sfmcold_emails_sent.id,
        sfmcold_emails_sent.value
 FROM public.sfmcold_emails_sent
 ORDER BY sfmcold_emails_sent.id,
          sfmcold_emails_sent.value
SEGMENTED BY hash(sfmcold_emails_sent.id, sfmcold_emails_sent.value) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_clicks /*+createtype(L)*/ 
(
 id,
 value
)
AS
 SELECT sfmcold_clicks.id,
        sfmcold_clicks.value
 FROM public.sfmcold_clicks
 ORDER BY sfmcold_clicks.id,
          sfmcold_clicks.value
SEGMENTED BY hash(sfmcold_clicks.id, sfmcold_clicks.value) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_bounces /*+createtype(L)*/ 
(
 id,
 value
)
AS
 SELECT sfmcold_bounces.id,
        sfmcold_bounces.value
 FROM public.sfmcold_bounces
 ORDER BY sfmcold_bounces.id,
          sfmcold_bounces.value
SEGMENTED BY hash(sfmcold_bounces.id, sfmcold_bounces.value) ALL NODES KSAFE 1;

CREATE PROJECTION public.cohort_churn /*+createtype(L)*/ 
(
 channel,
 geo,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 current_week,
 is_active,
 source,
 medium,
 campaign,
 content,
 distribution_id,
 default_search_engine,
 locale,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours
)
AS
 SELECT cohort_churn.channel,
        cohort_churn.geo,
        cohort_churn.is_funnelcake,
        cohort_churn.acquisition_period,
        cohort_churn.start_version,
        cohort_churn.sync_usage,
        cohort_churn.current_version,
        cohort_churn.current_week,
        cohort_churn.is_active,
        cohort_churn.source,
        cohort_churn.medium,
        cohort_churn.campaign,
        cohort_churn.content,
        cohort_churn.distribution_id,
        cohort_churn.default_search_engine,
        cohort_churn.locale,
        cohort_churn.n_profiles,
        cohort_churn.usage_hours,
        cohort_churn.sum_squared_usage_hours
 FROM public.cohort_churn
 ORDER BY cohort_churn.channel,
          cohort_churn.geo,
          cohort_churn.is_funnelcake,
          cohort_churn.acquisition_period,
          cohort_churn.start_version,
          cohort_churn.sync_usage,
          cohort_churn.current_version,
          cohort_churn.current_week,
          cohort_churn.is_active,
          cohort_churn.source,
          cohort_churn.medium,
          cohort_churn.campaign,
          cohort_churn.content,
          cohort_churn.distribution_id,
          cohort_churn.default_search_engine,
          cohort_churn.locale,
          cohort_churn.n_profiles,
          cohort_churn.usage_hours,
          cohort_churn.sum_squared_usage_hours
SEGMENTED BY hash(cohort_churn.geo, cohort_churn.is_funnelcake, cohort_churn.acquisition_period, cohort_churn.current_week, cohort_churn.is_active, cohort_churn.n_profiles, cohort_churn.usage_hours, cohort_churn.sum_squared_usage_hours, cohort_churn.start_version, cohort_churn.sync_usage, cohort_churn.current_version, cohort_churn.locale, cohort_churn.channel, cohort_churn.source, cohort_churn.medium, cohort_churn.campaign, cohort_churn.content, cohort_churn.distribution_id, cohort_churn.default_search_engine) ALL NODES KSAFE 1;

CREATE PROJECTION public.raw_scvp_okr /*+createtype(L)*/ 
(
 id,
 update_date,
 accountable_scvp,
 okr,
 status,
 score,
 metric_start,
 current_metric,
 target_metric,
 cur_month_status,
 next_milestone,
 status_owner,
 data_source,
 data_owner
)
AS
 SELECT raw_scvp_okr.id,
        raw_scvp_okr.update_date,
        raw_scvp_okr.accountable_scvp,
        raw_scvp_okr.okr,
        raw_scvp_okr.status,
        raw_scvp_okr.score,
        raw_scvp_okr.metric_start,
        raw_scvp_okr.current_metric,
        raw_scvp_okr.target_metric,
        raw_scvp_okr.cur_month_status,
        raw_scvp_okr.next_milestone,
        raw_scvp_okr.status_owner,
        raw_scvp_okr.data_source,
        raw_scvp_okr.data_owner
 FROM public.raw_scvp_okr
 ORDER BY raw_scvp_okr.id
SEGMENTED BY hash(raw_scvp_okr.id) ALL NODES KSAFE 1;

CREATE PROJECTION public.copy_cohort_churn /*+createtype(L)*/ 
(
 channel,
 geo,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 current_week,
 is_active,
 source,
 medium,
 campaign,
 content,
 distribution_id,
 default_search_engine,
 locale,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours
)
AS
 SELECT copy_cohort_churn.channel,
        copy_cohort_churn.geo,
        copy_cohort_churn.is_funnelcake,
        copy_cohort_churn.acquisition_period,
        copy_cohort_churn.start_version,
        copy_cohort_churn.sync_usage,
        copy_cohort_churn.current_version,
        copy_cohort_churn.current_week,
        copy_cohort_churn.is_active,
        copy_cohort_churn.source,
        copy_cohort_churn.medium,
        copy_cohort_churn.campaign,
        copy_cohort_churn.content,
        copy_cohort_churn.distribution_id,
        copy_cohort_churn.default_search_engine,
        copy_cohort_churn.locale,
        copy_cohort_churn.n_profiles,
        copy_cohort_churn.usage_hours,
        copy_cohort_churn.sum_squared_usage_hours
 FROM public.copy_cohort_churn
 ORDER BY copy_cohort_churn.channel,
          copy_cohort_churn.geo,
          copy_cohort_churn.is_funnelcake,
          copy_cohort_churn.acquisition_period,
          copy_cohort_churn.start_version,
          copy_cohort_churn.sync_usage,
          copy_cohort_churn.current_version,
          copy_cohort_churn.current_week,
          copy_cohort_churn.is_active,
          copy_cohort_churn.source,
          copy_cohort_churn.medium,
          copy_cohort_churn.campaign,
          copy_cohort_churn.content,
          copy_cohort_churn.distribution_id,
          copy_cohort_churn.default_search_engine,
          copy_cohort_churn.locale,
          copy_cohort_churn.n_profiles,
          copy_cohort_churn.usage_hours,
          copy_cohort_churn.sum_squared_usage_hours
SEGMENTED BY hash(copy_cohort_churn.geo, copy_cohort_churn.is_funnelcake, copy_cohort_churn.acquisition_period, copy_cohort_churn.current_week, copy_cohort_churn.is_active, copy_cohort_churn.n_profiles, copy_cohort_churn.usage_hours, copy_cohort_churn.sum_squared_usage_hours, copy_cohort_churn.start_version, copy_cohort_churn.sync_usage, copy_cohort_churn.current_version, copy_cohort_churn.locale, copy_cohort_churn.channel, copy_cohort_churn.source, copy_cohort_churn.medium, copy_cohort_churn.campaign, copy_cohort_churn.content, copy_cohort_churn.distribution_id, copy_cohort_churn.default_search_engine) ALL NODES KSAFE 1;

CREATE PROJECTION public.fx_market_share /*+createtype(L)*/ 
(
 fx_date,
 fx_mkt_share
)
AS
 SELECT fx_market_share.fx_date,
        fx_market_share.fx_mkt_share
 FROM public.fx_market_share
 ORDER BY fx_market_share.fx_date,
          fx_market_share.fx_mkt_share
SEGMENTED BY hash(fx_market_share.fx_date, fx_market_share.fx_mkt_share) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_tmp /*+createtype(L)*/ 
(
 sf_date,
 email_program,
 first_run_source,
 country,
 language,
 metric,
 value
)
AS
 SELECT sfmcold_tmp.sf_date,
        sfmcold_tmp.email_program,
        sfmcold_tmp.first_run_source,
        sfmcold_tmp.country,
        sfmcold_tmp.language,
        sfmcold_tmp.metric,
        sfmcold_tmp.value
 FROM public.sfmcold_tmp
 ORDER BY sfmcold_tmp.sf_date,
          sfmcold_tmp.email_program,
          sfmcold_tmp.first_run_source,
          sfmcold_tmp.country,
          sfmcold_tmp.language,
          sfmcold_tmp.metric,
          sfmcold_tmp.value
SEGMENTED BY hash(sfmcold_tmp.sf_date, sfmcold_tmp.first_run_source, sfmcold_tmp.language, sfmcold_tmp.value, sfmcold_tmp.email_program, sfmcold_tmp.country, sfmcold_tmp.metric) ALL NODES KSAFE 1;

CREATE PROJECTION public.fx_product_tmp /*+createtype(L)*/ 
(
 geo,
 channel,
 os,
 v4_date,
 actives,
 hours,
 inactives,
 new_records,
 five_of_seven,
 total_records,
 crashes,
 v4_default,
 google,
 bing,
 yahoo,
 other,
 dau,
 adi
)
AS
 SELECT fx_product_tmp.geo,
        fx_product_tmp.channel,
        fx_product_tmp.os,
        fx_product_tmp.v4_date,
        fx_product_tmp.actives,
        fx_product_tmp.hours,
        fx_product_tmp.inactives,
        fx_product_tmp.new_records,
        fx_product_tmp.five_of_seven,
        fx_product_tmp.total_records,
        fx_product_tmp.crashes,
        fx_product_tmp.v4_default,
        fx_product_tmp.google,
        fx_product_tmp.bing,
        fx_product_tmp.yahoo,
        fx_product_tmp.other,
        fx_product_tmp.dau,
        fx_product_tmp.adi
 FROM public.fx_product_tmp
 ORDER BY fx_product_tmp.geo,
          fx_product_tmp.channel,
          fx_product_tmp.os,
          fx_product_tmp.v4_date,
          fx_product_tmp.actives,
          fx_product_tmp.hours,
          fx_product_tmp.inactives,
          fx_product_tmp.new_records,
          fx_product_tmp.five_of_seven,
          fx_product_tmp.total_records,
          fx_product_tmp.crashes,
          fx_product_tmp.v4_default,
          fx_product_tmp.google,
          fx_product_tmp.bing,
          fx_product_tmp.yahoo,
          fx_product_tmp.other
SEGMENTED BY hash(fx_product_tmp.v4_date, fx_product_tmp.actives, fx_product_tmp.hours, fx_product_tmp.inactives, fx_product_tmp.new_records, fx_product_tmp.five_of_seven, fx_product_tmp.total_records, fx_product_tmp.crashes, fx_product_tmp.v4_default, fx_product_tmp.google, fx_product_tmp.bing, fx_product_tmp.yahoo, fx_product_tmp.other, fx_product_tmp.geo, fx_product_tmp.channel, fx_product_tmp.os) ALL NODES KSAFE 1;

CREATE PROJECTION public.org_okr_stage /*+createtype(L)*/ 
(
 type,
 status,
 okr,
 responsible,
 monthly_status,
 next_major_milestone,
 metric_at_start,
 current_metric,
 target_metric,
 score,
 data_source,
 data_owner,
 mozilla_okr,
 org_level_okr,
 modified_on,
 modified_by
)
AS
 SELECT org_okr_stage.type,
        org_okr_stage.status,
        org_okr_stage.okr,
        org_okr_stage.responsible,
        org_okr_stage.monthly_status,
        org_okr_stage.next_major_milestone,
        org_okr_stage.metric_at_start,
        org_okr_stage.current_metric,
        org_okr_stage.target_metric,
        org_okr_stage.score,
        org_okr_stage.data_source,
        org_okr_stage.data_owner,
        org_okr_stage.mozilla_okr,
        org_okr_stage.org_level_okr,
        org_okr_stage.modified_on,
        org_okr_stage.modified_by
 FROM public.org_okr_stage
 ORDER BY org_okr_stage.type,
          org_okr_stage.status,
          org_okr_stage.okr,
          org_okr_stage.responsible,
          org_okr_stage.monthly_status,
          org_okr_stage.next_major_milestone,
          org_okr_stage.metric_at_start,
          org_okr_stage.current_metric,
          org_okr_stage.target_metric,
          org_okr_stage.score,
          org_okr_stage.data_source,
          org_okr_stage.data_owner,
          org_okr_stage.mozilla_okr,
          org_okr_stage.org_level_okr,
          org_okr_stage.modified_on,
          org_okr_stage.modified_by
SEGMENTED BY hash(org_okr_stage.status, org_okr_stage.metric_at_start, org_okr_stage.current_metric, org_okr_stage.target_metric, org_okr_stage.score, org_okr_stage.type, org_okr_stage.mozilla_okr, org_okr_stage.okr, org_okr_stage.responsible, org_okr_stage.monthly_status, org_okr_stage.next_major_milestone, org_okr_stage.data_source, org_okr_stage.data_owner, org_okr_stage.org_level_okr, org_okr_stage.modified_on, org_okr_stage.modified_by) ALL NODES KSAFE 1;

CREATE PROJECTION public.org_okr_group /*+createtype(L)*/ 
(
 id,
 ts,
 name
)
AS
 SELECT org_okr_group.id,
        org_okr_group.ts,
        org_okr_group.name
 FROM public.org_okr_group
 ORDER BY org_okr_group.id
SEGMENTED BY hash(org_okr_group.id) ALL NODES KSAFE 1;

CREATE PROJECTION public.org_okr_type /*+createtype(L)*/ 
(
 type_id,
 group_id,
 duration,
 okr_type,
 status,
 okr_name,
 responsible,
 monthly_status,
 next_major_milestone,
 score,
 metric_at_start,
 current_metric,
 target_metric,
 data_source,
 data_owner,
 modified_on,
 modified_by
)
AS
 SELECT org_okr_type.type_id,
        org_okr_type.group_id,
        org_okr_type.duration,
        org_okr_type.okr_type,
        org_okr_type.status,
        org_okr_type.okr_name,
        org_okr_type.responsible,
        org_okr_type.monthly_status,
        org_okr_type.next_major_milestone,
        org_okr_type.score,
        org_okr_type.metric_at_start,
        org_okr_type.current_metric,
        org_okr_type.target_metric,
        org_okr_type.data_source,
        org_okr_type.data_owner,
        org_okr_type.modified_on,
        org_okr_type.modified_by
 FROM public.org_okr_type
 ORDER BY org_okr_type.type_id
SEGMENTED BY hash(org_okr_type.type_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.org_okr_keyresult /*+createtype(L)*/ 
(
 type_id,
 duration,
 okr_type,
 status,
 kr_name,
 responsible,
 monthly_status,
 next_major_milestone,
 score,
 metric_at_start,
 current_metric,
 target_metric,
 data_source,
 data_owner,
 modified_on,
 modified_by
)
AS
 SELECT org_okr_keyresult.type_id,
        org_okr_keyresult.duration,
        org_okr_keyresult.okr_type,
        org_okr_keyresult.status,
        org_okr_keyresult.kr_name,
        org_okr_keyresult.responsible,
        org_okr_keyresult.monthly_status,
        org_okr_keyresult.next_major_milestone,
        org_okr_keyresult.score,
        org_okr_keyresult.metric_at_start,
        org_okr_keyresult.current_metric,
        org_okr_keyresult.target_metric,
        org_okr_keyresult.data_source,
        org_okr_keyresult.data_owner,
        org_okr_keyresult.modified_on,
        org_okr_keyresult.modified_by
 FROM public.org_okr_keyresult
 ORDER BY org_okr_keyresult.type_id,
          org_okr_keyresult.duration,
          org_okr_keyresult.okr_type,
          org_okr_keyresult.status,
          org_okr_keyresult.kr_name,
          org_okr_keyresult.responsible,
          org_okr_keyresult.monthly_status,
          org_okr_keyresult.next_major_milestone,
          org_okr_keyresult.score,
          org_okr_keyresult.metric_at_start,
          org_okr_keyresult.current_metric,
          org_okr_keyresult.target_metric,
          org_okr_keyresult.data_source,
          org_okr_keyresult.data_owner,
          org_okr_keyresult.modified_on,
          org_okr_keyresult.modified_by
SEGMENTED BY hash(org_okr_keyresult.type_id, org_okr_keyresult.metric_at_start, org_okr_keyresult.current_metric, org_okr_keyresult.target_metric, org_okr_keyresult.status, org_okr_keyresult.okr_type, org_okr_keyresult.next_major_milestone, org_okr_keyresult.score, org_okr_keyresult.data_source, org_okr_keyresult.data_owner, org_okr_keyresult.modified_on, org_okr_keyresult.modified_by, org_okr_keyresult.duration, org_okr_keyresult.kr_name, org_okr_keyresult.responsible, org_okr_keyresult.monthly_status) ALL NODES KSAFE 1;

CREATE PROJECTION public.search_cohort_churn_v1 /*+createtype(L)*/ 
(
 channel,
 geo,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 current_week,
 is_active,
 source,
 medium,
 campaign,
 content,
 distribution_id,
 default_search_engine,
 locale,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours,
 week_start
)
AS
 SELECT search_cohort_churn.channel,
        search_cohort_churn.geo,
        search_cohort_churn.is_funnelcake,
        search_cohort_churn.acquisition_period,
        search_cohort_churn.start_version,
        search_cohort_churn.sync_usage,
        search_cohort_churn.current_version,
        search_cohort_churn.current_week,
        search_cohort_churn.is_active,
        search_cohort_churn.source,
        search_cohort_churn.medium,
        search_cohort_churn.campaign,
        search_cohort_churn.content,
        search_cohort_churn.distribution_id,
        search_cohort_churn.default_search_engine,
        search_cohort_churn.locale,
        search_cohort_churn.n_profiles,
        search_cohort_churn.usage_hours,
        search_cohort_churn.sum_squared_usage_hours,
        search_cohort_churn.week_start
 FROM public.search_cohort_churn
 ORDER BY search_cohort_churn.channel,
          search_cohort_churn.geo,
          search_cohort_churn.is_funnelcake,
          search_cohort_churn.acquisition_period,
          search_cohort_churn.start_version,
          search_cohort_churn.sync_usage,
          search_cohort_churn.current_version,
          search_cohort_churn.current_week,
          search_cohort_churn.is_active,
          search_cohort_churn.source,
          search_cohort_churn.medium,
          search_cohort_churn.campaign,
          search_cohort_churn.content,
          search_cohort_churn.distribution_id,
          search_cohort_churn.default_search_engine,
          search_cohort_churn.locale,
          search_cohort_churn.n_profiles,
          search_cohort_churn.usage_hours,
          search_cohort_churn.sum_squared_usage_hours,
          search_cohort_churn.week_start
SEGMENTED BY hash(search_cohort_churn.geo, search_cohort_churn.is_funnelcake, search_cohort_churn.acquisition_period, search_cohort_churn.current_week, search_cohort_churn.is_active, search_cohort_churn.n_profiles, search_cohort_churn.usage_hours, search_cohort_churn.sum_squared_usage_hours, search_cohort_churn.week_start, search_cohort_churn.start_version, search_cohort_churn.sync_usage, search_cohort_churn.current_version, search_cohort_churn.locale, search_cohort_churn.channel, search_cohort_churn.source, search_cohort_churn.medium, search_cohort_churn.campaign, search_cohort_churn.content, search_cohort_churn.distribution_id, search_cohort_churn.default_search_engine) ALL NODES KSAFE 1;

CREATE PROJECTION public.open_data_day /*+createtype(L)*/ 
(
 ts,
 first_name,
 last_name,
 email,
 locale
)
AS
 SELECT open_data_day.ts,
        open_data_day.first_name,
        open_data_day.last_name,
        open_data_day.email,
        open_data_day.locale
 FROM public.open_data_day
 ORDER BY open_data_day.ts,
          open_data_day.first_name,
          open_data_day.last_name,
          open_data_day.email,
          open_data_day.locale
SEGMENTED BY hash(open_data_day.ts, open_data_day.locale, open_data_day.first_name, open_data_day.last_name, open_data_day.email) ALL NODES KSAFE 1;

CREATE PROJECTION public.net_neutrality_petition /*+createtype(L)*/ 
(
 ts,
 first_name,
 last_name,
 email,
 locale
)
AS
 SELECT net_neutrality_petition.ts,
        net_neutrality_petition.first_name,
        net_neutrality_petition.last_name,
        net_neutrality_petition.email,
        net_neutrality_petition.locale
 FROM public.net_neutrality_petition
 ORDER BY net_neutrality_petition.ts,
          net_neutrality_petition.first_name,
          net_neutrality_petition.last_name,
          net_neutrality_petition.email,
          net_neutrality_petition.locale
SEGMENTED BY hash(net_neutrality_petition.ts, net_neutrality_petition.locale, net_neutrality_petition.first_name, net_neutrality_petition.last_name, net_neutrality_petition.email) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_donation_count /*+createtype(L)*/ 
(
 opp_name,
 opp_type,
 lead_source,
 amount,
 close_date,
 next_step,
 stage,
 probability,
 fiscal_period,
 age,
 created_date,
 opp_owner,
 owner_role,
 account_name
)
AS
 SELECT sf_donation_count.opp_name,
        sf_donation_count.opp_type,
        sf_donation_count.lead_source,
        sf_donation_count.amount,
        sf_donation_count.close_date,
        sf_donation_count.next_step,
        sf_donation_count.stage,
        sf_donation_count.probability,
        sf_donation_count.fiscal_period,
        sf_donation_count.age,
        sf_donation_count.created_date,
        sf_donation_count.opp_owner,
        sf_donation_count.owner_role,
        sf_donation_count.account_name
 FROM public.sf_donation_count
 ORDER BY sf_donation_count.opp_name,
          sf_donation_count.opp_type,
          sf_donation_count.lead_source,
          sf_donation_count.amount,
          sf_donation_count.close_date,
          sf_donation_count.next_step,
          sf_donation_count.stage,
          sf_donation_count.probability,
          sf_donation_count.fiscal_period,
          sf_donation_count.age,
          sf_donation_count.created_date,
          sf_donation_count.opp_owner,
          sf_donation_count.owner_role,
          sf_donation_count.account_name
SEGMENTED BY hash(sf_donation_count.amount, sf_donation_count.close_date, sf_donation_count.probability, sf_donation_count.fiscal_period, sf_donation_count.age, sf_donation_count.created_date, sf_donation_count.opp_name, sf_donation_count.stage, sf_donation_count.opp_type, sf_donation_count.lead_source, sf_donation_count.next_step, sf_donation_count.opp_owner, sf_donation_count.owner_role, sf_donation_count.account_name) ALL NODES KSAFE 1;

CREATE PROJECTION public.statcounter_monthly /*+createtype(L)*/ 
(
 st_date,
 stat
)
AS
 SELECT statcounter_monthly.st_date,
        statcounter_monthly.stat
 FROM public.statcounter_monthly
 ORDER BY statcounter_monthly.st_date,
          statcounter_monthly.stat
SEGMENTED BY hash(statcounter_monthly.st_date, statcounter_monthly.stat) ALL NODES KSAFE 1;

CREATE PROJECTION public.redash_focus_retention /*+createtype(L)*/ 
(
 os,
 cohort,
 week,
 cohort_size,
 weeK_num,
 active_users
)
AS
 SELECT redash_focus_retention.os,
        redash_focus_retention.cohort,
        redash_focus_retention.week,
        redash_focus_retention.cohort_size,
        redash_focus_retention.weeK_num,
        redash_focus_retention.active_users
 FROM public.redash_focus_retention
 ORDER BY redash_focus_retention.os,
          redash_focus_retention.cohort,
          redash_focus_retention.week,
          redash_focus_retention.cohort_size,
          redash_focus_retention.weeK_num,
          redash_focus_retention.active_users
SEGMENTED BY hash(redash_focus_retention.cohort, redash_focus_retention.week, redash_focus_retention.cohort_size, redash_focus_retention.weeK_num, redash_focus_retention.active_users, redash_focus_retention.os) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_fennec_retention_by_os /*+createtype(L)*/ 
(
 date,
 os,
 period,
 retention
)
AS
 SELECT adjust_fennec_retention_by_os.date,
        adjust_fennec_retention_by_os.os,
        adjust_fennec_retention_by_os.period,
        adjust_fennec_retention_by_os.retention
 FROM public.adjust_fennec_retention_by_os
 ORDER BY adjust_fennec_retention_by_os.date,
          adjust_fennec_retention_by_os.os,
          adjust_fennec_retention_by_os.period,
          adjust_fennec_retention_by_os.retention
SEGMENTED BY hash(adjust_fennec_retention_by_os.date, adjust_fennec_retention_by_os.period, adjust_fennec_retention_by_os.retention, adjust_fennec_retention_by_os.os) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_klar_daily_active_users /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus,
 installs
)
AS
 SELECT adjust_klar_daily_active_users.adj_date,
        adjust_klar_daily_active_users.daus,
        adjust_klar_daily_active_users.waus,
        adjust_klar_daily_active_users.maus,
        adjust_klar_daily_active_users.installs
 FROM public.adjust_klar_daily_active_users
 ORDER BY adjust_klar_daily_active_users.adj_date,
          adjust_klar_daily_active_users.daus,
          adjust_klar_daily_active_users.waus,
          adjust_klar_daily_active_users.maus
SEGMENTED BY hash(adjust_klar_daily_active_users.adj_date, adjust_klar_daily_active_users.daus, adjust_klar_daily_active_users.waus, adjust_klar_daily_active_users.maus) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_donations /*+createtype(L)*/ 
(
 opp_name,
 amount,
 contact_id
)
AS
 SELECT sf_donations.opp_name,
        sf_donations.amount,
        sf_donations.contact_id
 FROM public.sf_donations
 ORDER BY sf_donations.opp_name,
          sf_donations.amount,
          sf_donations.contact_id
SEGMENTED BY hash(sf_donations.amount, sf_donations.opp_name, sf_donations.contact_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.fhr_rollups_monthly_base /*+createtype(L)*/ 
(
 vendor,
 name,
 channel,
 os,
 osdetail,
 distribution,
 locale,
 geo,
 version,
 isstdprofile,
 stdchannel,
 stdos,
 distribtype,
 snapshot,
 granularity,
 timeStart,
 timeEnd,
 tTotalProfiles,
 tExistingProfiles,
 tNewProfiles,
 tActiveProfiles,
 tInActiveProfiles,
 tActiveDays,
 tTotalSeconds,
 tActiveSeconds,
 tNumSessions,
 tCrashes,
 tTotalSearch,
 tGoogleSearch,
 tYahooSearch,
 tBingSearch,
 tOfficialSearch,
 tIsDefault,
 tIsActiveProfileDefault,
 t5outOf7,
 tChurned,
 tHasUP
)
AS
 SELECT fhr_rollups_monthly_base.vendor,
        fhr_rollups_monthly_base.name,
        fhr_rollups_monthly_base.channel,
        fhr_rollups_monthly_base.os,
        fhr_rollups_monthly_base.osdetail,
        fhr_rollups_monthly_base.distribution,
        fhr_rollups_monthly_base.locale,
        fhr_rollups_monthly_base.geo,
        fhr_rollups_monthly_base.version,
        fhr_rollups_monthly_base.isstdprofile,
        fhr_rollups_monthly_base.stdchannel,
        fhr_rollups_monthly_base.stdos,
        fhr_rollups_monthly_base.distribtype,
        fhr_rollups_monthly_base.snapshot,
        fhr_rollups_monthly_base.granularity,
        fhr_rollups_monthly_base.timeStart,
        fhr_rollups_monthly_base.timeEnd,
        fhr_rollups_monthly_base.tTotalProfiles,
        fhr_rollups_monthly_base.tExistingProfiles,
        fhr_rollups_monthly_base.tNewProfiles,
        fhr_rollups_monthly_base.tActiveProfiles,
        fhr_rollups_monthly_base.tInActiveProfiles,
        fhr_rollups_monthly_base.tActiveDays,
        fhr_rollups_monthly_base.tTotalSeconds,
        fhr_rollups_monthly_base.tActiveSeconds,
        fhr_rollups_monthly_base.tNumSessions,
        fhr_rollups_monthly_base.tCrashes,
        fhr_rollups_monthly_base.tTotalSearch,
        fhr_rollups_monthly_base.tGoogleSearch,
        fhr_rollups_monthly_base.tYahooSearch,
        fhr_rollups_monthly_base.tBingSearch,
        fhr_rollups_monthly_base.tOfficialSearch,
        fhr_rollups_monthly_base.tIsDefault,
        fhr_rollups_monthly_base.tIsActiveProfileDefault,
        fhr_rollups_monthly_base.t5outOf7,
        fhr_rollups_monthly_base.tChurned,
        fhr_rollups_monthly_base.tHasUP
 FROM public.fhr_rollups_monthly_base
 ORDER BY fhr_rollups_monthly_base.vendor,
          fhr_rollups_monthly_base.name,
          fhr_rollups_monthly_base.channel,
          fhr_rollups_monthly_base.os,
          fhr_rollups_monthly_base.osdetail,
          fhr_rollups_monthly_base.distribution,
          fhr_rollups_monthly_base.locale,
          fhr_rollups_monthly_base.geo,
          fhr_rollups_monthly_base.version,
          fhr_rollups_monthly_base.isstdprofile,
          fhr_rollups_monthly_base.stdchannel,
          fhr_rollups_monthly_base.stdos,
          fhr_rollups_monthly_base.distribtype,
          fhr_rollups_monthly_base.snapshot,
          fhr_rollups_monthly_base.granularity,
          fhr_rollups_monthly_base.timeStart,
          fhr_rollups_monthly_base.timeEnd,
          fhr_rollups_monthly_base.tTotalProfiles,
          fhr_rollups_monthly_base.tExistingProfiles,
          fhr_rollups_monthly_base.tNewProfiles,
          fhr_rollups_monthly_base.tActiveProfiles,
          fhr_rollups_monthly_base.tInActiveProfiles,
          fhr_rollups_monthly_base.tActiveDays,
          fhr_rollups_monthly_base.tTotalSeconds,
          fhr_rollups_monthly_base.tActiveSeconds,
          fhr_rollups_monthly_base.tNumSessions,
          fhr_rollups_monthly_base.tCrashes,
          fhr_rollups_monthly_base.tTotalSearch,
          fhr_rollups_monthly_base.tGoogleSearch,
          fhr_rollups_monthly_base.tYahooSearch,
          fhr_rollups_monthly_base.tBingSearch,
          fhr_rollups_monthly_base.tOfficialSearch,
          fhr_rollups_monthly_base.tIsDefault,
          fhr_rollups_monthly_base.tIsActiveProfileDefault,
          fhr_rollups_monthly_base.t5outOf7,
          fhr_rollups_monthly_base.tChurned,
          fhr_rollups_monthly_base.tHasUP
SEGMENTED BY hash(fhr_rollups_monthly_base.tTotalProfiles, fhr_rollups_monthly_base.tExistingProfiles, fhr_rollups_monthly_base.tNewProfiles, fhr_rollups_monthly_base.tActiveProfiles, fhr_rollups_monthly_base.tInActiveProfiles, fhr_rollups_monthly_base.tActiveDays, fhr_rollups_monthly_base.tTotalSeconds, fhr_rollups_monthly_base.tActiveSeconds, fhr_rollups_monthly_base.tNumSessions, fhr_rollups_monthly_base.tCrashes, fhr_rollups_monthly_base.tTotalSearch, fhr_rollups_monthly_base.tGoogleSearch, fhr_rollups_monthly_base.tYahooSearch, fhr_rollups_monthly_base.tBingSearch, fhr_rollups_monthly_base.tOfficialSearch, fhr_rollups_monthly_base.tIsDefault, fhr_rollups_monthly_base.tIsActiveProfileDefault, fhr_rollups_monthly_base.t5outOf7, fhr_rollups_monthly_base.tChurned, fhr_rollups_monthly_base.tHasUP, fhr_rollups_monthly_base.vendor, fhr_rollups_monthly_base.name, fhr_rollups_monthly_base.channel, fhr_rollups_monthly_base.os, fhr_rollups_monthly_base.osdetail, fhr_rollups_monthly_base.distribution, fhr_rollups_monthly_base.locale, fhr_rollups_monthly_base.geo, fhr_rollups_monthly_base.version, fhr_rollups_monthly_base.isstdprofile, fhr_rollups_monthly_base.stdchannel, fhr_rollups_monthly_base.stdos) ALL NODES KSAFE 1;

CREATE PROJECTION public.fhr_rollups_monthly_base_2015 /*+createtype(L)*/ 
(
 vendor,
 name,
 channel,
 os,
 osdetail,
 distribution,
 locale,
 geo,
 version,
 isstdprofile,
 stdchannel,
 stdos,
 distribtype,
 snapshot,
 granularity,
 timeStart,
 timeEnd,
 tTotalProfiles,
 tExistingProfiles,
 tNewProfiles,
 tActiveProfiles,
 tInActiveProfiles,
 tActiveDays,
 tTotalSeconds,
 tActiveSeconds,
 tNumSessions,
 tCrashes,
 tTotalSearch,
 tGoogleSearch,
 tYahooSearch,
 tBingSearch,
 tOfficialSearch,
 tIsDefault,
 tIsActiveProfileDefault,
 t5outOf7,
 tChurned,
 tHasUP
)
AS
 SELECT fhr_rollups_monthly_base_2015.vendor,
        fhr_rollups_monthly_base_2015.name,
        fhr_rollups_monthly_base_2015.channel,
        fhr_rollups_monthly_base_2015.os,
        fhr_rollups_monthly_base_2015.osdetail,
        fhr_rollups_monthly_base_2015.distribution,
        fhr_rollups_monthly_base_2015.locale,
        fhr_rollups_monthly_base_2015.geo,
        fhr_rollups_monthly_base_2015.version,
        fhr_rollups_monthly_base_2015.isstdprofile,
        fhr_rollups_monthly_base_2015.stdchannel,
        fhr_rollups_monthly_base_2015.stdos,
        fhr_rollups_monthly_base_2015.distribtype,
        fhr_rollups_monthly_base_2015.snapshot,
        fhr_rollups_monthly_base_2015.granularity,
        fhr_rollups_monthly_base_2015.timeStart,
        fhr_rollups_monthly_base_2015.timeEnd,
        fhr_rollups_monthly_base_2015.tTotalProfiles,
        fhr_rollups_monthly_base_2015.tExistingProfiles,
        fhr_rollups_monthly_base_2015.tNewProfiles,
        fhr_rollups_monthly_base_2015.tActiveProfiles,
        fhr_rollups_monthly_base_2015.tInActiveProfiles,
        fhr_rollups_monthly_base_2015.tActiveDays,
        fhr_rollups_monthly_base_2015.tTotalSeconds,
        fhr_rollups_monthly_base_2015.tActiveSeconds,
        fhr_rollups_monthly_base_2015.tNumSessions,
        fhr_rollups_monthly_base_2015.tCrashes,
        fhr_rollups_monthly_base_2015.tTotalSearch,
        fhr_rollups_monthly_base_2015.tGoogleSearch,
        fhr_rollups_monthly_base_2015.tYahooSearch,
        fhr_rollups_monthly_base_2015.tBingSearch,
        fhr_rollups_monthly_base_2015.tOfficialSearch,
        fhr_rollups_monthly_base_2015.tIsDefault,
        fhr_rollups_monthly_base_2015.tIsActiveProfileDefault,
        fhr_rollups_monthly_base_2015.t5outOf7,
        fhr_rollups_monthly_base_2015.tChurned,
        fhr_rollups_monthly_base_2015.tHasUP
 FROM public.fhr_rollups_monthly_base_2015
 ORDER BY fhr_rollups_monthly_base_2015.vendor,
          fhr_rollups_monthly_base_2015.name,
          fhr_rollups_monthly_base_2015.channel,
          fhr_rollups_monthly_base_2015.os,
          fhr_rollups_monthly_base_2015.osdetail,
          fhr_rollups_monthly_base_2015.distribution,
          fhr_rollups_monthly_base_2015.locale,
          fhr_rollups_monthly_base_2015.geo,
          fhr_rollups_monthly_base_2015.version,
          fhr_rollups_monthly_base_2015.isstdprofile,
          fhr_rollups_monthly_base_2015.stdchannel,
          fhr_rollups_monthly_base_2015.stdos,
          fhr_rollups_monthly_base_2015.distribtype,
          fhr_rollups_monthly_base_2015.snapshot,
          fhr_rollups_monthly_base_2015.granularity,
          fhr_rollups_monthly_base_2015.timeStart,
          fhr_rollups_monthly_base_2015.timeEnd,
          fhr_rollups_monthly_base_2015.tTotalProfiles,
          fhr_rollups_monthly_base_2015.tExistingProfiles,
          fhr_rollups_monthly_base_2015.tNewProfiles,
          fhr_rollups_monthly_base_2015.tActiveProfiles,
          fhr_rollups_monthly_base_2015.tInActiveProfiles,
          fhr_rollups_monthly_base_2015.tActiveDays,
          fhr_rollups_monthly_base_2015.tTotalSeconds,
          fhr_rollups_monthly_base_2015.tActiveSeconds,
          fhr_rollups_monthly_base_2015.tNumSessions,
          fhr_rollups_monthly_base_2015.tCrashes,
          fhr_rollups_monthly_base_2015.tTotalSearch,
          fhr_rollups_monthly_base_2015.tGoogleSearch,
          fhr_rollups_monthly_base_2015.tYahooSearch,
          fhr_rollups_monthly_base_2015.tBingSearch,
          fhr_rollups_monthly_base_2015.tOfficialSearch,
          fhr_rollups_monthly_base_2015.tIsDefault,
          fhr_rollups_monthly_base_2015.tIsActiveProfileDefault,
          fhr_rollups_monthly_base_2015.t5outOf7,
          fhr_rollups_monthly_base_2015.tChurned,
          fhr_rollups_monthly_base_2015.tHasUP
SEGMENTED BY hash(fhr_rollups_monthly_base_2015.tTotalProfiles, fhr_rollups_monthly_base_2015.tExistingProfiles, fhr_rollups_monthly_base_2015.tNewProfiles, fhr_rollups_monthly_base_2015.tActiveProfiles, fhr_rollups_monthly_base_2015.tInActiveProfiles, fhr_rollups_monthly_base_2015.tActiveDays, fhr_rollups_monthly_base_2015.tTotalSeconds, fhr_rollups_monthly_base_2015.tActiveSeconds, fhr_rollups_monthly_base_2015.tNumSessions, fhr_rollups_monthly_base_2015.tCrashes, fhr_rollups_monthly_base_2015.tTotalSearch, fhr_rollups_monthly_base_2015.tGoogleSearch, fhr_rollups_monthly_base_2015.tYahooSearch, fhr_rollups_monthly_base_2015.tBingSearch, fhr_rollups_monthly_base_2015.tOfficialSearch, fhr_rollups_monthly_base_2015.tIsDefault, fhr_rollups_monthly_base_2015.tIsActiveProfileDefault, fhr_rollups_monthly_base_2015.t5outOf7, fhr_rollups_monthly_base_2015.tChurned, fhr_rollups_monthly_base_2015.tHasUP, fhr_rollups_monthly_base_2015.vendor, fhr_rollups_monthly_base_2015.name, fhr_rollups_monthly_base_2015.channel, fhr_rollups_monthly_base_2015.os, fhr_rollups_monthly_base_2015.osdetail, fhr_rollups_monthly_base_2015.distribution, fhr_rollups_monthly_base_2015.locale, fhr_rollups_monthly_base_2015.geo, fhr_rollups_monthly_base_2015.version, fhr_rollups_monthly_base_2015.isstdprofile, fhr_rollups_monthly_base_2015.stdchannel, fhr_rollups_monthly_base_2015.stdos) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_daily_active_users /*+createtype(L)*/ 
(
 adj_date,
 os,
 daus,
 waus,
 maus,
 installs,
 app
)
AS
 SELECT adjust_daily_active_users.adj_date,
        adjust_daily_active_users.os,
        adjust_daily_active_users.daus,
        adjust_daily_active_users.waus,
        adjust_daily_active_users.maus,
        adjust_daily_active_users.installs,
        adjust_daily_active_users.app
 FROM public.adjust_daily_active_users
 ORDER BY adjust_daily_active_users.adj_date,
          adjust_daily_active_users.os,
          adjust_daily_active_users.daus,
          adjust_daily_active_users.waus,
          adjust_daily_active_users.maus,
          adjust_daily_active_users.installs,
          adjust_daily_active_users.app
SEGMENTED BY hash(adjust_daily_active_users.adj_date, adjust_daily_active_users.daus, adjust_daily_active_users.waus, adjust_daily_active_users.maus, adjust_daily_active_users.installs, adjust_daily_active_users.os, adjust_daily_active_users.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.churn_cohort /*+createtype(L)*/ 
(
 channel,
 country,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 week_since_acquisition,
 is_active,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours
)
AS
 SELECT churn_cohort.channel,
        churn_cohort.country,
        churn_cohort.is_funnelcake,
        churn_cohort.acquisition_period,
        churn_cohort.start_version,
        churn_cohort.sync_usage,
        churn_cohort.current_version,
        churn_cohort.week_since_acquisition,
        churn_cohort.is_active,
        churn_cohort.n_profiles,
        churn_cohort.usage_hours,
        churn_cohort.sum_squared_usage_hours
 FROM public.churn_cohort
 ORDER BY churn_cohort.channel,
          churn_cohort.country,
          churn_cohort.is_funnelcake,
          churn_cohort.acquisition_period,
          churn_cohort.start_version,
          churn_cohort.sync_usage,
          churn_cohort.current_version,
          churn_cohort.week_since_acquisition,
          churn_cohort.is_active,
          churn_cohort.n_profiles,
          churn_cohort.usage_hours,
          churn_cohort.sum_squared_usage_hours
SEGMENTED BY hash(churn_cohort.country, churn_cohort.is_funnelcake, churn_cohort.acquisition_period, churn_cohort.week_since_acquisition, churn_cohort.is_active, churn_cohort.n_profiles, churn_cohort.usage_hours, churn_cohort.sum_squared_usage_hours, churn_cohort.start_version, churn_cohort.sync_usage, churn_cohort.current_version, churn_cohort.channel) ALL NODES KSAFE 1;

CREATE PROJECTION public.fx_attribution /*+createtype(L)*/ 
(
 profiles_count,
 source,
 medium,
 campaign,
 content
)
AS
 SELECT fx_attribution.profiles_count,
        fx_attribution.source,
        fx_attribution.medium,
        fx_attribution.campaign,
        fx_attribution.content
 FROM public.fx_attribution
 ORDER BY fx_attribution.profiles_count,
          fx_attribution.source,
          fx_attribution.medium,
          fx_attribution.campaign,
          fx_attribution.content
SEGMENTED BY hash(fx_attribution.profiles_count, fx_attribution.source, fx_attribution.medium, fx_attribution.campaign, fx_attribution.content) ALL NODES KSAFE 1;

CREATE PROJECTION public.snippet_count_new_a_super /*+basename(snippet_count_new_a),createtype(L)*/ 
(
 date,
 ua_family,
 ua_major,
 os_family,
 country_code,
 snippet_id,
 impression_count,
 locale,
 metric,
 user_country,
 campaign
)
AS
 SELECT snippet_count.date,
        snippet_count.ua_family,
        snippet_count.ua_major,
        snippet_count.os_family,
        snippet_count.country_code,
        snippet_count.snippet_id,
        snippet_count.impression_count,
        snippet_count.locale,
        snippet_count.metric,
        snippet_count.user_country,
        snippet_count.campaign
 FROM public.snippet_count
 ORDER BY snippet_count.date,
          snippet_count.ua_family,
          snippet_count.ua_major,
          snippet_count.os_family,
          snippet_count.country_code,
          snippet_count.snippet_id,
          snippet_count.impression_count,
          snippet_count.locale,
          snippet_count.metric
SEGMENTED BY hash(snippet_count.date, snippet_count.ua_major, snippet_count.country_code, snippet_count.impression_count, snippet_count.user_country, snippet_count.ua_family, snippet_count.os_family, snippet_count.snippet_id, snippet_count.locale, snippet_count.metric, snippet_count.campaign) ALL NODES OFFSET 0;

CREATE PROJECTION public.snippet_count_new_a_super_b2
(
 date,
 ua_family,
 ua_major,
 os_family,
 country_code,
 snippet_id,
 impression_count,
 locale,
 metric,
 user_country,
 campaign
)
AS
 SELECT snippet_count.date,
        snippet_count.ua_family,
        snippet_count.ua_major,
        snippet_count.os_family,
        snippet_count.country_code,
        snippet_count.snippet_id,
        snippet_count.impression_count,
        snippet_count.locale,
        snippet_count.metric,
        snippet_count.user_country,
        snippet_count.campaign
 FROM public.snippet_count
 ORDER BY snippet_count.date,
          snippet_count.ua_family,
          snippet_count.ua_major,
          snippet_count.os_family,
          snippet_count.country_code,
          snippet_count.snippet_id,
          snippet_count.impression_count,
          snippet_count.locale,
          snippet_count.metric
SEGMENTED BY hash(snippet_count.date, snippet_count.ua_major, snippet_count.country_code, snippet_count.impression_count, snippet_count.user_country, snippet_count.ua_family, snippet_count.os_family, snippet_count.snippet_id, snippet_count.locale, snippet_count.metric, snippet_count.campaign) ALL NODES OFFSET 1;

CREATE PROJECTION public.ut_desktop_daily_active_users_extended /*+createtype(L)*/ 
(
 day,
 mau,
 dau,
 smooth_dau
)
AS
 SELECT ut_desktop_daily_active_users_extended.day,
        ut_desktop_daily_active_users_extended.mau,
        ut_desktop_daily_active_users_extended.dau,
        ut_desktop_daily_active_users_extended.smooth_dau
 FROM public.ut_desktop_daily_active_users_extended
 ORDER BY ut_desktop_daily_active_users_extended.day,
          ut_desktop_daily_active_users_extended.mau,
          ut_desktop_daily_active_users_extended.dau,
          ut_desktop_daily_active_users_extended.smooth_dau
SEGMENTED BY hash(ut_desktop_daily_active_users_extended.day, ut_desktop_daily_active_users_extended.mau, ut_desktop_daily_active_users_extended.dau, ut_desktop_daily_active_users_extended.smooth_dau) ALL NODES KSAFE 1;

CREATE PROJECTION public.mozilla_staff_plus /*+createtype(L)*/ 
(
 employee_id,
 first_name,
 last_name,
 email_address,
 supervisory_organization,
 cost_center,
 functional_group,
 manager_id,
 manager_lastname,
 manager_firstname,
 manager_email,
 is_manager,
 hire_date,
 location,
 home_city,
 home_country,
 home_postal,
 desk_number,
 snapshot_date
)
AS
 SELECT mozilla_staff_plus.employee_id,
        mozilla_staff_plus.first_name,
        mozilla_staff_plus.last_name,
        mozilla_staff_plus.email_address,
        mozilla_staff_plus.supervisory_organization,
        mozilla_staff_plus.cost_center,
        mozilla_staff_plus.functional_group,
        mozilla_staff_plus.manager_id,
        mozilla_staff_plus.manager_lastname,
        mozilla_staff_plus.manager_firstname,
        mozilla_staff_plus.manager_email,
        mozilla_staff_plus.is_manager,
        mozilla_staff_plus.hire_date,
        mozilla_staff_plus.location,
        mozilla_staff_plus.home_city,
        mozilla_staff_plus.home_country,
        mozilla_staff_plus.home_postal,
        mozilla_staff_plus.desk_number,
        mozilla_staff_plus.snapshot_date
 FROM public.mozilla_staff_plus
 ORDER BY mozilla_staff_plus.employee_id,
          mozilla_staff_plus.first_name,
          mozilla_staff_plus.last_name,
          mozilla_staff_plus.email_address,
          mozilla_staff_plus.supervisory_organization,
          mozilla_staff_plus.cost_center,
          mozilla_staff_plus.functional_group,
          mozilla_staff_plus.manager_id,
          mozilla_staff_plus.manager_lastname,
          mozilla_staff_plus.manager_firstname,
          mozilla_staff_plus.manager_email,
          mozilla_staff_plus.is_manager,
          mozilla_staff_plus.hire_date,
          mozilla_staff_plus.location,
          mozilla_staff_plus.home_city,
          mozilla_staff_plus.home_country,
          mozilla_staff_plus.home_postal,
          mozilla_staff_plus.desk_number,
          mozilla_staff_plus.snapshot_date
SEGMENTED BY hash(mozilla_staff_plus.is_manager, mozilla_staff_plus.hire_date, mozilla_staff_plus.snapshot_date, mozilla_staff_plus.employee_id, mozilla_staff_plus.first_name, mozilla_staff_plus.last_name, mozilla_staff_plus.supervisory_organization, mozilla_staff_plus.cost_center, mozilla_staff_plus.functional_group, mozilla_staff_plus.manager_id, mozilla_staff_plus.manager_lastname, mozilla_staff_plus.manager_firstname, mozilla_staff_plus.location, mozilla_staff_plus.home_city, mozilla_staff_plus.home_country, mozilla_staff_plus.home_postal, mozilla_staff_plus.desk_number, mozilla_staff_plus.email_address, mozilla_staff_plus.manager_email) ALL NODES KSAFE 1;

CREATE PROJECTION public.pocket_mobile_daily_active_users /*+createtype(L)*/ 
(
 activity_date,
 platform,
 dau,
 wau_rolling_7,
 mau_rolling_30,
 mau_rolling_31,
 mau_rolling_28,
 app
)
AS
 SELECT pocket_mobile_daily_active_users.activity_date,
        pocket_mobile_daily_active_users.platform,
        pocket_mobile_daily_active_users.dau,
        pocket_mobile_daily_active_users.wau_rolling_7,
        pocket_mobile_daily_active_users.mau_rolling_30,
        pocket_mobile_daily_active_users.mau_rolling_31,
        pocket_mobile_daily_active_users.mau_rolling_28,
        pocket_mobile_daily_active_users.app
 FROM public.pocket_mobile_daily_active_users
 ORDER BY pocket_mobile_daily_active_users.activity_date,
          pocket_mobile_daily_active_users.platform,
          pocket_mobile_daily_active_users.dau,
          pocket_mobile_daily_active_users.wau_rolling_7,
          pocket_mobile_daily_active_users.mau_rolling_30,
          pocket_mobile_daily_active_users.mau_rolling_31,
          pocket_mobile_daily_active_users.mau_rolling_28,
          pocket_mobile_daily_active_users.app
SEGMENTED BY hash(pocket_mobile_daily_active_users.activity_date, pocket_mobile_daily_active_users.platform, pocket_mobile_daily_active_users.dau, pocket_mobile_daily_active_users.wau_rolling_7, pocket_mobile_daily_active_users.mau_rolling_30, pocket_mobile_daily_active_users.mau_rolling_31, pocket_mobile_daily_active_users.mau_rolling_28, pocket_mobile_daily_active_users.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_daily /*+createtype(L)*/ 
(
 client_id,
 submission_date_s3,
 os,
 city,
 geo_subdivision1,
 country,
 search_count_all_sum,
 profile_age_in_days,
 subsession_hours_sum,
 active_hours_sum,
 pageviews
)
AS
 SELECT ut_clients_daily.client_id,
        ut_clients_daily.submission_date_s3,
        ut_clients_daily.os,
        ut_clients_daily.city,
        ut_clients_daily.geo_subdivision1,
        ut_clients_daily.country,
        ut_clients_daily.search_count_all_sum,
        ut_clients_daily.profile_age_in_days,
        ut_clients_daily.subsession_hours_sum,
        ut_clients_daily.active_hours_sum,
        ut_clients_daily.pageviews
 FROM public.ut_clients_daily
 ORDER BY ut_clients_daily.client_id,
          ut_clients_daily.submission_date_s3,
          ut_clients_daily.os,
          ut_clients_daily.city,
          ut_clients_daily.geo_subdivision1,
          ut_clients_daily.country,
          ut_clients_daily.search_count_all_sum,
          ut_clients_daily.profile_age_in_days,
          ut_clients_daily.subsession_hours_sum,
          ut_clients_daily.active_hours_sum,
          ut_clients_daily.pageviews
SEGMENTED BY hash(ut_clients_daily.submission_date_s3, ut_clients_daily.os, ut_clients_daily.city, ut_clients_daily.geo_subdivision1, ut_clients_daily.country) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_daily_client_id_proj /*+createtype(L)*/ 
(
 client_id,
 submission_date_s3,
 os,
 city,
 geo_subdivision1,
 country,
 search_count_all_sum,
 profile_age_in_days,
 subsession_hours_sum,
 active_hours_sum,
 pageviews
)
AS
 SELECT ut_clients_daily.client_id,
        ut_clients_daily.submission_date_s3,
        ut_clients_daily.os,
        ut_clients_daily.city,
        ut_clients_daily.geo_subdivision1,
        ut_clients_daily.country,
        ut_clients_daily.search_count_all_sum,
        ut_clients_daily.profile_age_in_days,
        ut_clients_daily.subsession_hours_sum,
        ut_clients_daily.active_hours_sum,
        ut_clients_daily.pageviews
 FROM public.ut_clients_daily
 ORDER BY ut_clients_daily.client_id,
          ut_clients_daily.submission_date_s3,
          ut_clients_daily.os,
          ut_clients_daily.city,
          ut_clients_daily.geo_subdivision1,
          ut_clients_daily.country,
          ut_clients_daily.search_count_all_sum,
          ut_clients_daily.profile_age_in_days,
          ut_clients_daily.subsession_hours_sum,
          ut_clients_daily.active_hours_sum,
          ut_clients_daily.pageviews
SEGMENTED BY hash(ut_clients_daily.client_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_daily_ltv /*+createtype(L)*/ 
(
 client_id,
 max_submission_date,
 os,
 city,
 geo_subdivision1,
 country,
 total_search_count_all_sum,
 max_profile_age_in_days,
 total_subsession_hours_sum,
 total_active_hours_sum,
 total_pageviews,
 frequency,
 recency,
 customer_age,
 avg_session_value,
 predicted_searches_14_days,
 alive_probability,
 predicted_clv_12_months,
 historical_searches,
 historical_clv,
 days_since_last_active,
 user_status,
 calc_date,
 total_clv
)
AS
 SELECT ut_clients_daily_ltv.client_id,
        ut_clients_daily_ltv.max_submission_date,
        ut_clients_daily_ltv.os,
        ut_clients_daily_ltv.city,
        ut_clients_daily_ltv.geo_subdivision1,
        ut_clients_daily_ltv.country,
        ut_clients_daily_ltv.total_search_count_all_sum,
        ut_clients_daily_ltv.max_profile_age_in_days,
        ut_clients_daily_ltv.total_subsession_hours_sum,
        ut_clients_daily_ltv.total_active_hours_sum,
        ut_clients_daily_ltv.total_pageviews,
        ut_clients_daily_ltv.frequency,
        ut_clients_daily_ltv.recency,
        ut_clients_daily_ltv.customer_age,
        ut_clients_daily_ltv.avg_session_value,
        ut_clients_daily_ltv.predicted_searches_14_days,
        ut_clients_daily_ltv.alive_probability,
        ut_clients_daily_ltv.predicted_clv_12_months,
        ut_clients_daily_ltv.historical_searches,
        ut_clients_daily_ltv.historical_clv,
        ut_clients_daily_ltv.days_since_last_active,
        ut_clients_daily_ltv.user_status,
        ut_clients_daily_ltv.calc_date,
        ut_clients_daily_ltv.total_clv
 FROM public.ut_clients_daily_ltv
 ORDER BY ut_clients_daily_ltv.client_id,
          ut_clients_daily_ltv.max_submission_date,
          ut_clients_daily_ltv.os,
          ut_clients_daily_ltv.city,
          ut_clients_daily_ltv.geo_subdivision1,
          ut_clients_daily_ltv.country,
          ut_clients_daily_ltv.total_search_count_all_sum,
          ut_clients_daily_ltv.max_profile_age_in_days
SEGMENTED BY hash(ut_clients_daily_ltv.client_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_daily_aggr /*+createtype(L)*/ 
(
 calc_date,
 attribute,
 value,
 count,
 mean_predicted_clv_12_months,
 mean_historical_searches,
 mean_historical_clv,
 median_predicted_clv_12_months,
 median_historical_searches,
 median_historical_clv,
 lower_95ci_predicted_clv_12_months,
 upper_95ci_predicted_clv_12_months,
 lower_95ci_historical_searches,
 upper_95ci_historical_searches,
 lower_95ci_historical_clv,
 upper_95ci_historical_clv,
 lower_99ci_predicted_clv_12_months,
 upper_99ci_predicted_clv_12_months,
 lower_99ci_historical_searches,
 upper_99ci_historical_searches,
 lower_99ci_historical_clv,
 upper_99ci_historical_clv
)
AS
 SELECT ut_clients_daily_aggr.calc_date,
        ut_clients_daily_aggr.attribute,
        ut_clients_daily_aggr.value,
        ut_clients_daily_aggr.count,
        ut_clients_daily_aggr.mean_predicted_clv_12_months,
        ut_clients_daily_aggr.mean_historical_searches,
        ut_clients_daily_aggr.mean_historical_clv,
        ut_clients_daily_aggr.median_predicted_clv_12_months,
        ut_clients_daily_aggr.median_historical_searches,
        ut_clients_daily_aggr.median_historical_clv,
        ut_clients_daily_aggr.lower_95ci_predicted_clv_12_months,
        ut_clients_daily_aggr.upper_95ci_predicted_clv_12_months,
        ut_clients_daily_aggr.lower_95ci_historical_searches,
        ut_clients_daily_aggr.upper_95ci_historical_searches,
        ut_clients_daily_aggr.lower_95ci_historical_clv,
        ut_clients_daily_aggr.upper_95ci_historical_clv,
        ut_clients_daily_aggr.lower_99ci_predicted_clv_12_months,
        ut_clients_daily_aggr.upper_99ci_predicted_clv_12_months,
        ut_clients_daily_aggr.lower_99ci_historical_searches,
        ut_clients_daily_aggr.upper_99ci_historical_searches,
        ut_clients_daily_aggr.lower_99ci_historical_clv,
        ut_clients_daily_aggr.upper_99ci_historical_clv
 FROM public.ut_clients_daily_aggr
 ORDER BY ut_clients_daily_aggr.calc_date,
          ut_clients_daily_aggr.attribute,
          ut_clients_daily_aggr.value,
          ut_clients_daily_aggr.count
SEGMENTED BY hash(ut_clients_daily_aggr.calc_date, ut_clients_daily_aggr.attribute, ut_clients_daily_aggr.value) ALL NODES KSAFE 1;

CREATE PROJECTION public.reviews /*+createtype(L)*/ 
(
 ID,
 Store,
 Device,
 Source,
 Country,
 "Review Date",
 Version,
 Rating,
 "Original Reviews",
 "Translated Reviews",
 Sentiment,
 Spam,
 "Verb Phrases",
 "Noun Phrases",
 "Clear Filters"
)
AS
 SELECT reviews.ID,
        reviews.Store,
        reviews.Device,
        reviews.Source,
        reviews.Country,
        reviews."Review Date",
        reviews.Version,
        reviews.Rating,
        reviews."Original Reviews",
        reviews."Translated Reviews",
        reviews.Sentiment,
        reviews.Spam,
        reviews."Verb Phrases",
        reviews."Noun Phrases",
        reviews."Clear Filters"
 FROM public.reviews
 ORDER BY reviews.ID
SEGMENTED BY hash(reviews.ID) ALL NODES KSAFE 1;

CREATE PROJECTION public.categorization /*+createtype(L)*/ 
(
 ID,
 Feature,
 Component,
 theAction
)
AS
 SELECT categorization.ID,
        categorization.Feature,
        categorization.Component,
        categorization.theAction
 FROM public.categorization
 ORDER BY categorization.ID,
          categorization.Feature,
          categorization.Component,
          categorization.theAction
SEGMENTED BY hash(categorization.ID, categorization.Feature, categorization.Component, categorization.theAction) ALL NODES KSAFE 1;

CREATE PROJECTION public.key_issue /*+createtype(L)*/ 
(
 ID,
 "Key Issue"
)
AS
 SELECT key_issue.ID,
        key_issue."Key Issue"
 FROM public.key_issue
 ORDER BY key_issue.ID,
          key_issue."Key Issue"
SEGMENTED BY hash(key_issue.ID, key_issue."Key Issue") ALL NODES KSAFE 1;

CREATE PROJECTION public.locations_DBD_1_rep_vu_query /*+createtype(D)*/ 
(
 country_code ENCODING RLE,
 country_name,
 region_name
)
AS
 SELECT locations.country_code,
        locations.country_name,
        locations.region_name
 FROM public.locations
 ORDER BY locations.country_code,
          locations.country_name,
          locations.region_name
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.copy_adi_dimensional_by_date_DBD_2_seg_vu_query /*+createtype(D)*/ 
(
 bl_date ENCODING RLE,
 product ENCODING RLE,
 cntry_code ENCODING RLE,
 tot_requests_on_date ENCODING DELTARANGE_COMP
)
AS
 SELECT copy_adi_dimensional_by_date.bl_date,
        copy_adi_dimensional_by_date.product,
        copy_adi_dimensional_by_date.cntry_code,
        copy_adi_dimensional_by_date.tot_requests_on_date
 FROM public.copy_adi_dimensional_by_date
 ORDER BY copy_adi_dimensional_by_date.bl_date,
          copy_adi_dimensional_by_date.product,
          copy_adi_dimensional_by_date.cntry_code,
          copy_adi_dimensional_by_date.tot_requests_on_date
SEGMENTED BY hash(copy_adi_dimensional_by_date.cntry_code) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_daily_ltv_test /*+createtype(L)*/ 
(
 client_id,
 max_submission_date,
 os,
 city,
 geo_subdivision1,
 country,
 total_search_count_all_sum,
 max_profile_age_in_days,
 total_subsession_hours_sum,
 total_active_hours_sum,
 total_pageviews,
 frequency,
 recency,
 customer_age,
 avg_session_value,
 predicted_searches_14_days,
 alive_probability,
 predicted_clv_12_months,
 historical_searches,
 historical_clv,
 days_since_last_active,
 user_status,
 calc_date,
 total_clv
)
AS
 SELECT ut_clients_daily_ltv.client_id,
        ut_clients_daily_ltv.max_submission_date,
        ut_clients_daily_ltv.os,
        ut_clients_daily_ltv.city,
        ut_clients_daily_ltv.geo_subdivision1,
        ut_clients_daily_ltv.country,
        ut_clients_daily_ltv.total_search_count_all_sum,
        ut_clients_daily_ltv.max_profile_age_in_days,
        ut_clients_daily_ltv.total_subsession_hours_sum,
        ut_clients_daily_ltv.total_active_hours_sum,
        ut_clients_daily_ltv.total_pageviews,
        ut_clients_daily_ltv.frequency,
        ut_clients_daily_ltv.recency,
        ut_clients_daily_ltv.customer_age,
        ut_clients_daily_ltv.avg_session_value,
        ut_clients_daily_ltv.predicted_searches_14_days,
        ut_clients_daily_ltv.alive_probability,
        ut_clients_daily_ltv.predicted_clv_12_months,
        ut_clients_daily_ltv.historical_searches,
        ut_clients_daily_ltv.historical_clv,
        ut_clients_daily_ltv.days_since_last_active,
        ut_clients_daily_ltv.user_status,
        ut_clients_daily_ltv.calc_date,
        ut_clients_daily_ltv.total_clv
 FROM public.ut_clients_daily_ltv_test ut_clients_daily_ltv
 ORDER BY ut_clients_daily_ltv.client_id,
          ut_clients_daily_ltv.max_submission_date,
          ut_clients_daily_ltv.os,
          ut_clients_daily_ltv.city,
          ut_clients_daily_ltv.geo_subdivision1,
          ut_clients_daily_ltv.country,
          ut_clients_daily_ltv.total_search_count_all_sum,
          ut_clients_daily_ltv.max_profile_age_in_days
SEGMENTED BY hash(ut_clients_daily_ltv.client_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_search_history /*+createtype(L)*/ 
(
 client_id,
 submission_date_s3,
 sap
)
AS
 SELECT ut_clients_search_history.client_id,
        ut_clients_search_history.submission_date_s3,
        ut_clients_search_history.sap
 FROM public.ut_clients_search_history
 ORDER BY ut_clients_search_history.client_id,
          ut_clients_search_history.submission_date_s3
SEGMENTED BY hash(ut_clients_search_history.client_id, ut_clients_search_history.submission_date_s3) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_daily_details /*+createtype(L)*/ 
(
 client_id,
 os,
 os_version,
 city,
 geo_subdivision1,
 geo_subdivision2,
 country,
 default_search_engine,
 default_search_engine_data_submission_url,
 default_search_engine_data_load_path,
 default_search_engine_data_origin,
 e10s_enabled,
 channel,
 locale,
 is_default_browser,
 memory_mb,
 os_service_pack_major,
 os_service_pack_minor,
 sample_id,
 profile_creation_date,
 profile_age_in_days,
 active_addons_count_mean,
 sync_configured,
 sync_count_desktop_sum,
 sync_count_mobile_sum,
 places_bookmarks_count_mean,
 timezone_offset,
 attribution_site,
 source,
 medium,
 campaign,
 content,
 submission_date_s3,
 max_activity_date,
 activity_group
)
AS
 SELECT ut_clients_daily_details.client_id,
        ut_clients_daily_details.os,
        ut_clients_daily_details.os_version,
        ut_clients_daily_details.city,
        ut_clients_daily_details.geo_subdivision1,
        ut_clients_daily_details.geo_subdivision2,
        ut_clients_daily_details.country,
        ut_clients_daily_details.default_search_engine,
        ut_clients_daily_details.default_search_engine_data_submission_url,
        ut_clients_daily_details.default_search_engine_data_load_path,
        ut_clients_daily_details.default_search_engine_data_origin,
        ut_clients_daily_details.e10s_enabled,
        ut_clients_daily_details.channel,
        ut_clients_daily_details.locale,
        ut_clients_daily_details.is_default_browser,
        ut_clients_daily_details.memory_mb,
        ut_clients_daily_details.os_service_pack_major,
        ut_clients_daily_details.os_service_pack_minor,
        ut_clients_daily_details.sample_id,
        ut_clients_daily_details.profile_creation_date,
        ut_clients_daily_details.profile_age_in_days,
        ut_clients_daily_details.active_addons_count_mean,
        ut_clients_daily_details.sync_configured,
        ut_clients_daily_details.sync_count_desktop_sum,
        ut_clients_daily_details.sync_count_mobile_sum,
        ut_clients_daily_details.places_bookmarks_count_mean,
        ut_clients_daily_details.timezone_offset,
        ut_clients_daily_details.attribution_site,
        ut_clients_daily_details.source,
        ut_clients_daily_details.medium,
        ut_clients_daily_details.campaign,
        ut_clients_daily_details.content,
        ut_clients_daily_details.submission_date_s3,
        ut_clients_daily_details.max_activity_date,
        ut_clients_daily_details.activity_group
 FROM public.ut_clients_daily_details
 ORDER BY ut_clients_daily_details.client_id,
          ut_clients_daily_details.submission_date_s3
SEGMENTED BY hash(ut_clients_daily_details.client_id, ut_clients_daily_details.submission_date_s3) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_country_revenue /*+createtype(L)*/ 
(
 country_code,
 yyyymm,
 rev_per_search
)
AS
 SELECT ut_country_revenue.country_code,
        ut_country_revenue.yyyymm,
        ut_country_revenue.rev_per_search
 FROM public.ut_country_revenue
 ORDER BY ut_country_revenue.country_code,
          ut_country_revenue.yyyymm,
          ut_country_revenue.rev_per_search
SEGMENTED BY hash(ut_country_revenue.yyyymm, ut_country_revenue.rev_per_search, ut_country_revenue.country_code) ALL NODES KSAFE 1;

CREATE PROJECTION public.utl_clients_ltv /*+createtype(L)*/ 
(
 client_id,
 frequency,
 recency,
 customer_age,
 avg_session_value,
 predicted_searches_14_days,
 alive_probability,
 predicted_clv_12_months,
 historical_searches,
 historical_clv,
 total_clv,
 days_since_last_active,
 user_status,
 calc_date
)
AS
 SELECT ut_clients_ltv.client_id,
        ut_clients_ltv.frequency,
        ut_clients_ltv.recency,
        ut_clients_ltv.customer_age,
        ut_clients_ltv.avg_session_value,
        ut_clients_ltv.predicted_searches_14_days,
        ut_clients_ltv.alive_probability,
        ut_clients_ltv.predicted_clv_12_months,
        ut_clients_ltv.historical_searches,
        ut_clients_ltv.historical_clv,
        ut_clients_ltv.total_clv,
        ut_clients_ltv.days_since_last_active,
        ut_clients_ltv.user_status,
        ut_clients_ltv.calc_date
 FROM public.ut_clients_ltv
 ORDER BY ut_clients_ltv.client_id,
          ut_clients_ltv.calc_date
SEGMENTED BY hash(ut_clients_ltv.client_id, ut_clients_ltv.calc_date) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_country_revenue_mock /*+createtype(L)*/ 
(
 country_code,
 yyyymm,
 rev_per_search
)
AS
 SELECT ut_country_revenue.country_code,
        ut_country_revenue.yyyymm,
        ut_country_revenue.rev_per_search
 FROM public.ut_country_revenue_mock ut_country_revenue
 ORDER BY ut_country_revenue.country_code,
          ut_country_revenue.yyyymm,
          ut_country_revenue.rev_per_search
SEGMENTED BY hash(ut_country_revenue.yyyymm, ut_country_revenue.rev_per_search, ut_country_revenue.country_code) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_clients_daily_details_old /*+createtype(L)*/ 
(
 client_id,
 os,
 os_version,
 city,
 geo_subdivision1,
 geo_subdivision2,
 country,
 default_search_engine,
 default_search_engine_data_submission_url,
 default_search_engine_data_load_path,
 default_search_engine_data_origin,
 e10s_enabled,
 channel,
 locale,
 is_default_browser,
 memory_mb,
 os_service_pack_major,
 os_service_pack_minor,
 sample_id,
 profile_creation_date,
 profile_age_in_days,
 active_addons_count_mean,
 sync_configured,
 sync_count_desktop_sum,
 sync_count_mobile_sum,
 places_bookmarks_count_mean,
 timezone_offset,
 attribution_site,
 source,
 medium,
 campaign,
 content,
 submission_date_s3,
 max_activity_date,
 activity_group
)
AS
 SELECT ut_clients_daily_details.client_id,
        ut_clients_daily_details.os,
        ut_clients_daily_details.os_version,
        ut_clients_daily_details.city,
        ut_clients_daily_details.geo_subdivision1,
        ut_clients_daily_details.geo_subdivision2,
        ut_clients_daily_details.country,
        ut_clients_daily_details.default_search_engine,
        ut_clients_daily_details.default_search_engine_data_submission_url,
        ut_clients_daily_details.default_search_engine_data_load_path,
        ut_clients_daily_details.default_search_engine_data_origin,
        ut_clients_daily_details.e10s_enabled,
        ut_clients_daily_details.channel,
        ut_clients_daily_details.locale,
        ut_clients_daily_details.is_default_browser,
        ut_clients_daily_details.memory_mb,
        ut_clients_daily_details.os_service_pack_major,
        ut_clients_daily_details.os_service_pack_minor,
        ut_clients_daily_details.sample_id,
        ut_clients_daily_details.profile_creation_date,
        ut_clients_daily_details.profile_age_in_days,
        ut_clients_daily_details.active_addons_count_mean,
        ut_clients_daily_details.sync_configured,
        ut_clients_daily_details.sync_count_desktop_sum,
        ut_clients_daily_details.sync_count_mobile_sum,
        ut_clients_daily_details.places_bookmarks_count_mean,
        ut_clients_daily_details.timezone_offset,
        ut_clients_daily_details.attribution_site,
        ut_clients_daily_details.source,
        ut_clients_daily_details.medium,
        ut_clients_daily_details.campaign,
        ut_clients_daily_details.content,
        ut_clients_daily_details.submission_date_s3,
        ut_clients_daily_details.max_activity_date,
        ut_clients_daily_details.activity_group
 FROM public.ut_clients_daily_details_old ut_clients_daily_details
 ORDER BY ut_clients_daily_details.client_id,
          ut_clients_daily_details.submission_date_s3
SEGMENTED BY hash(ut_clients_daily_details.client_id, ut_clients_daily_details.submission_date_s3) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_events /*+createtype(L)*/ 
(
 send_id,
 subscriber_id,
 list_id,
 event_date,
 event_type,
 send_url_id,
 url_id,
 url,
 alias,
 batch_id,
 triggered_send_external_key,
 source_file
)
AS
 SELECT sfmc_events.send_id,
        sfmc_events.subscriber_id,
        sfmc_events.list_id,
        sfmc_events.event_date,
        sfmc_events.event_type,
        sfmc_events.send_url_id,
        sfmc_events.url_id,
        sfmc_events.url,
        sfmc_events.alias,
        sfmc_events.batch_id,
        sfmc_events.triggered_send_external_key,
        sfmc_events.source_file
 FROM public.sfmc_events
 ORDER BY sfmc_events.send_id,
          sfmc_events.subscriber_id,
          sfmc_events.list_id,
          sfmc_events.event_date,
          sfmc_events.event_type,
          sfmc_events.send_url_id,
          sfmc_events.url_id,
          sfmc_events.url,
          sfmc_events.alias,
          sfmc_events.batch_id,
          sfmc_events.triggered_send_external_key,
          sfmc_events.source_file
SEGMENTED BY hash(sfmc_events.send_id, sfmc_events.subscriber_id, sfmc_events.list_id, sfmc_events.event_date, sfmc_events.send_url_id, sfmc_events.url_id, sfmc_events.batch_id, sfmc_events.event_type, sfmc_events.url, sfmc_events.alias, sfmc_events.triggered_send_external_key, sfmc_events.source_file) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_send_jobs /*+createtype(L)*/ 
(
 send_id,
 from_name,
 from_email,
 sched_time,
 sent_time,
 subject,
 email_name,
 triggered_send_external_key,
 send_definition_external_key,
 job_status,
 preview_url,
 is_multipart,
 additional,
 source_file
)
AS
 SELECT sfmc_send_jobs.send_id,
        sfmc_send_jobs.from_name,
        sfmc_send_jobs.from_email,
        sfmc_send_jobs.sched_time,
        sfmc_send_jobs.sent_time,
        sfmc_send_jobs.subject,
        sfmc_send_jobs.email_name,
        sfmc_send_jobs.triggered_send_external_key,
        sfmc_send_jobs.send_definition_external_key,
        sfmc_send_jobs.job_status,
        sfmc_send_jobs.preview_url,
        sfmc_send_jobs.is_multipart,
        sfmc_send_jobs.additional,
        sfmc_send_jobs.source_file
 FROM public.sfmc_send_jobs
 ORDER BY sfmc_send_jobs.send_id,
          sfmc_send_jobs.from_name,
          sfmc_send_jobs.from_email,
          sfmc_send_jobs.sched_time,
          sfmc_send_jobs.sent_time,
          sfmc_send_jobs.subject,
          sfmc_send_jobs.email_name,
          sfmc_send_jobs.triggered_send_external_key,
          sfmc_send_jobs.send_definition_external_key,
          sfmc_send_jobs.job_status,
          sfmc_send_jobs.preview_url,
          sfmc_send_jobs.is_multipart,
          sfmc_send_jobs.additional,
          sfmc_send_jobs.source_file
SEGMENTED BY hash(sfmc_send_jobs.send_id, sfmc_send_jobs.sched_time, sfmc_send_jobs.sent_time, sfmc_send_jobs.send_definition_external_key, sfmc_send_jobs.is_multipart, sfmc_send_jobs.job_status, sfmc_send_jobs.from_name, sfmc_send_jobs.from_email, sfmc_send_jobs.subject, sfmc_send_jobs.email_name, sfmc_send_jobs.triggered_send_external_key, sfmc_send_jobs.preview_url, sfmc_send_jobs.additional, sfmc_send_jobs.source_file) ALL NODES KSAFE 1;

CREATE PROJECTION public.sfmc_subscribers /*+createtype(L)*/ 
(
 subscriber_id,
 status,
 date_held,
 date_created,
 date_unsubscribed,
 source_file
)
AS
 SELECT sfmc_subscribers.subscriber_id,
        sfmc_subscribers.status,
        sfmc_subscribers.date_held,
        sfmc_subscribers.date_created,
        sfmc_subscribers.date_unsubscribed,
        sfmc_subscribers.source_file
 FROM public.sfmc_subscribers
 ORDER BY sfmc_subscribers.subscriber_id,
          sfmc_subscribers.status,
          sfmc_subscribers.date_held,
          sfmc_subscribers.date_created,
          sfmc_subscribers.date_unsubscribed,
          sfmc_subscribers.source_file
SEGMENTED BY hash(sfmc_subscribers.subscriber_id, sfmc_subscribers.date_held, sfmc_subscribers.date_created, sfmc_subscribers.date_unsubscribed, sfmc_subscribers.status, sfmc_subscribers.source_file) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_summary /*+createtype(L)*/ 
(
 date,
 rollup_name,
 rollup_value,
 mailing_country,
 email_language,
 email_format
)
AS
 SELECT sf_summary.date,
        sf_summary.rollup_name,
        sf_summary.rollup_value,
        sf_summary.mailing_country,
        sf_summary.email_language,
        sf_summary.email_format
 FROM public.sf_summary
 ORDER BY sf_summary.mailing_country,
          sf_summary.email_language
SEGMENTED BY hash(sf_summary.mailing_country, sf_summary.email_language) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_client_aggr /*+createtype(L)*/ 
(
 calc_date,
 attribute,
 value,
 count_hltv,
 mean_hltv,
 mode_hltv,
 ptile10_hltv,
 ptile25_hltv,
 median_hltv,
 ptile75_hltv,
 ptile90_hltv,
 std_hltv,
 skew_hltv,
 kurtosis_hltv,
 margin_err_90_hltv,
 ci90_lower_hltv,
 ci90_upper_hltv,
 margin_err_95_hltv,
 ci95_lower_hltv,
 ci95_upper_hltv,
 margin_err_99_hltv,
 ci99_lower_hltv,
 ci99_upper_hltv,
 count_pltv,
 mean_pltv,
 mode_pltv,
 ptile10_pltv,
 ptile25_pltv,
 median_pltv,
 ptile75_pltv,
 ptile90_pltv,
 std_pltv,
 skew_pltv,
 kurtosis_pltv,
 margin_err_90_pltv,
 ci90_lower_pltv,
 ci90_upper_pltv,
 margin_err_95_pltv,
 ci95_lower_pltv,
 ci95_upper_pltv,
 margin_err_99_pltv,
 ci99_lower_pltv,
 ci99_upper_pltv,
 count_tltv,
 mean_tltv,
 mode_tltv,
 ptile10_tltv,
 ptile25_tltv,
 median_tltv,
 ptile75_tltv,
 ptile90_tltv,
 std_tltv,
 skew_tltv,
 kurtosis_tltv,
 margin_err_90_tltv,
 ci90_lower_tltv,
 ci90_upper_tltv,
 margin_err_95_tltv,
 ci95_lower_tltv,
 ci95_upper_tltv,
 margin_err_99_tltv,
 ci99_lower_tltv,
 ci99_upper_tltv,
 count_historical_searches,
 mean_historical_searches,
 mode_historical_searches,
 ptile10_historical_searches,
 ptile25_historical_searches,
 median_historical_searches,
 ptile75_historical_searches,
 ptile90_historical_searches,
 std_historical_searches,
 skew_historical_searches,
 kurtosis_historical_searches,
 margin_err_90_historical_searches,
 ci90_lower_historical_searches,
 ci90_upper_historical_searches,
 margin_err_95_historical_searches,
 ci95_lower_historical_searches,
 ci95_upper_historical_searches,
 margin_err_99_historical_searches,
 ci99_lower_historical_searches,
 ci99_upper_historical_searches,
 count_customer_age,
 mean_customer_age,
 mode_customer_age,
 ptile10_customer_age,
 ptile25_customer_age,
 median_customer_age,
 ptile75_customer_age,
 ptile90_customer_age,
 std_customer_age,
 skew_customer_age,
 kurtosis_customer_age,
 margin_err_90_customer_age,
 ci90_lower_customer_age,
 ci90_upper_customer_age,
 margin_err_95_customer_age,
 ci95_lower_customer_age,
 ci95_upper_customer_age,
 margin_err_99_customer_age,
 ci99_lower_customer_age,
 ci99_upper_customer_age
)
AS
 SELECT ut_clients_aggr.calc_date,
        ut_clients_aggr.attribute,
        ut_clients_aggr.value,
        ut_clients_aggr.count_hltv,
        ut_clients_aggr.mean_hltv,
        ut_clients_aggr.mode_hltv,
        ut_clients_aggr.ptile10_hltv,
        ut_clients_aggr.ptile25_hltv,
        ut_clients_aggr.median_hltv,
        ut_clients_aggr.ptile75_hltv,
        ut_clients_aggr.ptile90_hltv,
        ut_clients_aggr.std_hltv,
        ut_clients_aggr.skew_hltv,
        ut_clients_aggr.kurtosis_hltv,
        ut_clients_aggr.margin_err_90_hltv,
        ut_clients_aggr.ci90_lower_hltv,
        ut_clients_aggr.ci90_upper_hltv,
        ut_clients_aggr.margin_err_95_hltv,
        ut_clients_aggr.ci95_lower_hltv,
        ut_clients_aggr.ci95_upper_hltv,
        ut_clients_aggr.margin_err_99_hltv,
        ut_clients_aggr.ci99_lower_hltv,
        ut_clients_aggr.ci99_upper_hltv,
        ut_clients_aggr.count_pltv,
        ut_clients_aggr.mean_pltv,
        ut_clients_aggr.mode_pltv,
        ut_clients_aggr.ptile10_pltv,
        ut_clients_aggr.ptile25_pltv,
        ut_clients_aggr.median_pltv,
        ut_clients_aggr.ptile75_pltv,
        ut_clients_aggr.ptile90_pltv,
        ut_clients_aggr.std_pltv,
        ut_clients_aggr.skew_pltv,
        ut_clients_aggr.kurtosis_pltv,
        ut_clients_aggr.margin_err_90_pltv,
        ut_clients_aggr.ci90_lower_pltv,
        ut_clients_aggr.ci90_upper_pltv,
        ut_clients_aggr.margin_err_95_pltv,
        ut_clients_aggr.ci95_lower_pltv,
        ut_clients_aggr.ci95_upper_pltv,
        ut_clients_aggr.margin_err_99_pltv,
        ut_clients_aggr.ci99_lower_pltv,
        ut_clients_aggr.ci99_upper_pltv,
        ut_clients_aggr.count_tltv,
        ut_clients_aggr.mean_tltv,
        ut_clients_aggr.mode_tltv,
        ut_clients_aggr.ptile10_tltv,
        ut_clients_aggr.ptile25_tltv,
        ut_clients_aggr.median_tltv,
        ut_clients_aggr.ptile75_tltv,
        ut_clients_aggr.ptile90_tltv,
        ut_clients_aggr.std_tltv,
        ut_clients_aggr.skew_tltv,
        ut_clients_aggr.kurtosis_tltv,
        ut_clients_aggr.margin_err_90_tltv,
        ut_clients_aggr.ci90_lower_tltv,
        ut_clients_aggr.ci90_upper_tltv,
        ut_clients_aggr.margin_err_95_tltv,
        ut_clients_aggr.ci95_lower_tltv,
        ut_clients_aggr.ci95_upper_tltv,
        ut_clients_aggr.margin_err_99_tltv,
        ut_clients_aggr.ci99_lower_tltv,
        ut_clients_aggr.ci99_upper_tltv,
        ut_clients_aggr.count_historical_searches,
        ut_clients_aggr.mean_historical_searches,
        ut_clients_aggr.mode_historical_searches,
        ut_clients_aggr.ptile10_historical_searches,
        ut_clients_aggr.ptile25_historical_searches,
        ut_clients_aggr.median_historical_searches,
        ut_clients_aggr.ptile75_historical_searches,
        ut_clients_aggr.ptile90_historical_searches,
        ut_clients_aggr.std_historical_searches,
        ut_clients_aggr.skew_historical_searches,
        ut_clients_aggr.kurtosis_historical_searches,
        ut_clients_aggr.margin_err_90_historical_searches,
        ut_clients_aggr.ci90_lower_historical_searches,
        ut_clients_aggr.ci90_upper_historical_searches,
        ut_clients_aggr.margin_err_95_historical_searches,
        ut_clients_aggr.ci95_lower_historical_searches,
        ut_clients_aggr.ci95_upper_historical_searches,
        ut_clients_aggr.margin_err_99_historical_searches,
        ut_clients_aggr.ci99_lower_historical_searches,
        ut_clients_aggr.ci99_upper_historical_searches,
        ut_clients_aggr.count_customer_age,
        ut_clients_aggr.mean_customer_age,
        ut_clients_aggr.mode_customer_age,
        ut_clients_aggr.ptile10_customer_age,
        ut_clients_aggr.ptile25_customer_age,
        ut_clients_aggr.median_customer_age,
        ut_clients_aggr.ptile75_customer_age,
        ut_clients_aggr.ptile90_customer_age,
        ut_clients_aggr.std_customer_age,
        ut_clients_aggr.skew_customer_age,
        ut_clients_aggr.kurtosis_customer_age,
        ut_clients_aggr.margin_err_90_customer_age,
        ut_clients_aggr.ci90_lower_customer_age,
        ut_clients_aggr.ci90_upper_customer_age,
        ut_clients_aggr.margin_err_95_customer_age,
        ut_clients_aggr.ci95_lower_customer_age,
        ut_clients_aggr.ci95_upper_customer_age,
        ut_clients_aggr.margin_err_99_customer_age,
        ut_clients_aggr.ci99_lower_customer_age,
        ut_clients_aggr.ci99_upper_customer_age
 FROM public.ut_clients_aggr
 ORDER BY ut_clients_aggr.calc_date,
          ut_clients_aggr.attribute,
          ut_clients_aggr.value,
          ut_clients_aggr.count_historical_searches
SEGMENTED BY hash(ut_clients_aggr.calc_date, ut_clients_aggr.attribute, ut_clients_aggr.value) ALL NODES KSAFE 1;

CREATE PROJECTION public.credentials /*+createtype(L)*/ 
(
 user_name,
 account,
 aws_access_key_id,
 aws_secret_access_key
)
AS
 SELECT credentials.user_name,
        credentials.account,
        credentials.aws_access_key_id,
        credentials.aws_secret_access_key
 FROM public.credentials
 ORDER BY credentials.user_name,
          credentials.account,
          credentials.aws_access_key_id,
          credentials.aws_secret_access_key
SEGMENTED BY hash(credentials.user_name, credentials.account, credentials.aws_access_key_id, credentials.aws_secret_access_key) ALL NODES KSAFE 1;

CREATE PROJECTION public.f_bugs_status_changes /*+createtype(L)*/ 
(
 bug_id,
 bug_severity,
 bug_status_current,
 bug_status_previous,
 bug_version_num,
 assigned_to,
 component,
 created_by,
 created_ts,
 modified_by,
 modified_ts,
 op_sys,
 priority,
 product,
 qa_contact,
 reported_by,
 reporter,
 version,
 expires_on,
 cf_due_date,
 target_milestone,
 keywords,
 snapshot_date,
 load_date,
 load_source
)
AS
 SELECT f_bugs_status_changes.bug_id,
        f_bugs_status_changes.bug_severity,
        f_bugs_status_changes.bug_status_current,
        f_bugs_status_changes.bug_status_previous,
        f_bugs_status_changes.bug_version_num,
        f_bugs_status_changes.assigned_to,
        f_bugs_status_changes.component,
        f_bugs_status_changes.created_by,
        f_bugs_status_changes.created_ts,
        f_bugs_status_changes.modified_by,
        f_bugs_status_changes.modified_ts,
        f_bugs_status_changes.op_sys,
        f_bugs_status_changes.priority,
        f_bugs_status_changes.product,
        f_bugs_status_changes.qa_contact,
        f_bugs_status_changes.reported_by,
        f_bugs_status_changes.reporter,
        f_bugs_status_changes.version,
        f_bugs_status_changes.expires_on,
        f_bugs_status_changes.cf_due_date,
        f_bugs_status_changes.target_milestone,
        f_bugs_status_changes.keywords,
        f_bugs_status_changes.snapshot_date,
        f_bugs_status_changes.load_date,
        f_bugs_status_changes.load_source
 FROM public.f_bugs_status_changes
 ORDER BY f_bugs_status_changes.bug_id,
          f_bugs_status_changes.reporter,
          f_bugs_status_changes.priority,
          f_bugs_status_changes.modified_ts
SEGMENTED BY hash(f_bugs_status_changes.bug_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.firefox_download_counts_staging /*+createtype(L)*/ 
(
 date,
 country_code,
 count,
 ua_family,
 ua_major,
 os_family,
 product_name,
 product_type,
 download_type,
 other,
 locale
)
AS
 SELECT firefox_download_counts.date,
        firefox_download_counts.country_code,
        firefox_download_counts.count,
        firefox_download_counts.ua_family,
        firefox_download_counts.ua_major,
        firefox_download_counts.os_family,
        firefox_download_counts.product_name,
        firefox_download_counts.product_type,
        firefox_download_counts.download_type,
        firefox_download_counts.other,
        firefox_download_counts.locale
 FROM public.firefox_download_counts
 ORDER BY firefox_download_counts.date,
          firefox_download_counts.country_code,
          firefox_download_counts.count,
          firefox_download_counts.ua_family,
          firefox_download_counts.ua_major,
          firefox_download_counts.os_family,
          firefox_download_counts.product_name,
          firefox_download_counts.product_type,
          firefox_download_counts.download_type,
          firefox_download_counts.other
SEGMENTED BY hash(firefox_download_counts.count, firefox_download_counts.date, firefox_download_counts.country_code, firefox_download_counts.ua_family, firefox_download_counts.ua_major, firefox_download_counts.os_family, firefox_download_counts.download_type, firefox_download_counts.product_name, firefox_download_counts.product_type, firefox_download_counts.other) ALL NODES KSAFE 1;

CREATE PROJECTION public.user_locales /*+createtype(L)*/ 
(
 raw_locale,
 normalized_locale
)
AS
 SELECT user_locales.raw_locale,
        user_locales.normalized_locale
 FROM public.user_locales
 ORDER BY user_locales.raw_locale,
          user_locales.normalized_locale
SEGMENTED BY hash(user_locales.raw_locale, user_locales.normalized_locale) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_android_daily_active_users /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus
)
AS
 SELECT adjust_android_daily_active_users.adj_date,
        adjust_android_daily_active_users.daus,
        adjust_android_daily_active_users.waus,
        adjust_android_daily_active_users.maus
 FROM public.adjust_android_daily_active_users
 ORDER BY adjust_android_daily_active_users.adj_date,
          adjust_android_daily_active_users.daus,
          adjust_android_daily_active_users.waus,
          adjust_android_daily_active_users.maus
SEGMENTED BY hash(adjust_android_daily_active_users.adj_date, adjust_android_daily_active_users.daus, adjust_android_daily_active_users.waus, adjust_android_daily_active_users.maus) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_foundation_signups /*+createtype(L)*/ 
(
 contact_id,
 signup_date
)
AS
 SELECT sf_foundation_signups.contact_id,
        sf_foundation_signups.signup_date
 FROM public.sf_foundation_signups
 ORDER BY sf_foundation_signups.contact_id,
          sf_foundation_signups.signup_date
SEGMENTED BY hash(sf_foundation_signups.signup_date, sf_foundation_signups.contact_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_copyright_petition /*+createtype(L)*/ 
(
 contact_id,
 signed_on_date
)
AS
 SELECT sf_copyright_petition.contact_id,
        sf_copyright_petition.signed_on_date
 FROM public.sf_copyright_petition
 ORDER BY sf_copyright_petition.contact_id,
          sf_copyright_petition.signed_on_date
SEGMENTED BY hash(sf_copyright_petition.signed_on_date, sf_copyright_petition.contact_id) ALL NODES KSAFE 1;

CREATE PROJECTION public.sf_contacts /*+createtype(L)*/ 
(
 id,
 created_date,
 email,
 email_format,
 contact_name,
 email_language,
 signup_source_url,
 confirmation_miti_subscriber,
 sub_apps_and_hacks,
 sub_firefox_and_you,
 sub_firefox_accounts_journey,
 sub_mozilla_foundation,
 sub_miti_subscriber,
 sub_mozilla_leadership_network,
 sub_mozilla_learning_network,
 sub_webmaker,
 sub_mozillians_nda,
 sub_open_innovation_subscriber,
 subscriber,
 sub_test_flight,
 sub_test_pilot,
 sub_view_source_global,
 sub_view_source_namerica,
 double_opt_in,
 unengaged,
 email_opt_out,
 mailing_country
)
AS
 SELECT sf_contacts.id,
        sf_contacts.created_date,
        sf_contacts.email,
        sf_contacts.email_format,
        sf_contacts.contact_name,
        sf_contacts.email_language,
        sf_contacts.signup_source_url,
        sf_contacts.confirmation_miti_subscriber,
        sf_contacts.sub_apps_and_hacks,
        sf_contacts.sub_firefox_and_you,
        sf_contacts.sub_firefox_accounts_journey,
        sf_contacts.sub_mozilla_foundation,
        sf_contacts.sub_miti_subscriber,
        sf_contacts.sub_mozilla_leadership_network,
        sf_contacts.sub_mozilla_learning_network,
        sf_contacts.sub_webmaker,
        sf_contacts.sub_mozillians_nda,
        sf_contacts.sub_open_innovation_subscriber,
        sf_contacts.subscriber,
        sf_contacts.sub_test_flight,
        sf_contacts.sub_test_pilot,
        sf_contacts.sub_view_source_global,
        sf_contacts.sub_view_source_namerica,
        sf_contacts.double_opt_in,
        sf_contacts.unengaged,
        sf_contacts.email_opt_out,
        sf_contacts.mailing_country
 FROM public.sf_contacts
 ORDER BY sf_contacts.id,
          sf_contacts.created_date,
          sf_contacts.email,
          sf_contacts.email_format,
          sf_contacts.contact_name,
          sf_contacts.email_language,
          sf_contacts.signup_source_url,
          sf_contacts.confirmation_miti_subscriber,
          sf_contacts.sub_apps_and_hacks,
          sf_contacts.sub_firefox_and_you,
          sf_contacts.sub_firefox_accounts_journey,
          sf_contacts.sub_mozilla_foundation,
          sf_contacts.sub_miti_subscriber,
          sf_contacts.sub_mozilla_leadership_network,
          sf_contacts.sub_mozilla_learning_network,
          sf_contacts.sub_webmaker,
          sf_contacts.sub_mozillians_nda,
          sf_contacts.sub_open_innovation_subscriber,
          sf_contacts.subscriber,
          sf_contacts.sub_test_flight,
          sf_contacts.sub_test_pilot,
          sf_contacts.sub_view_source_global,
          sf_contacts.sub_view_source_namerica,
          sf_contacts.double_opt_in,
          sf_contacts.unengaged,
          sf_contacts.email_opt_out
SEGMENTED BY hash(sf_contacts.created_date, sf_contacts.email_format, sf_contacts.confirmation_miti_subscriber, sf_contacts.sub_apps_and_hacks, sf_contacts.sub_firefox_and_you, sf_contacts.sub_firefox_accounts_journey, sf_contacts.sub_mozilla_foundation, sf_contacts.sub_miti_subscriber, sf_contacts.sub_mozilla_leadership_network, sf_contacts.sub_mozilla_learning_network, sf_contacts.sub_webmaker, sf_contacts.sub_mozillians_nda, sf_contacts.sub_open_innovation_subscriber, sf_contacts.subscriber, sf_contacts.sub_test_flight, sf_contacts.sub_test_pilot, sf_contacts.sub_view_source_global, sf_contacts.sub_view_source_namerica, sf_contacts.double_opt_in, sf_contacts.unengaged, sf_contacts.email_opt_out, sf_contacts.email_language, sf_contacts.id, sf_contacts.email, sf_contacts.contact_name, sf_contacts.signup_source_url) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_daily_active_users_test /*+createtype(L)*/ 
(
 adj_date,
 os,
 daus,
 waus,
 maus,
 installs,
 app
)
AS
 SELECT adjust_daily_active_users_test.adj_date,
        adjust_daily_active_users_test.os,
        adjust_daily_active_users_test.daus,
        adjust_daily_active_users_test.waus,
        adjust_daily_active_users_test.maus,
        adjust_daily_active_users_test.installs,
        adjust_daily_active_users_test.app
 FROM public.adjust_daily_active_users_test
 ORDER BY adjust_daily_active_users_test.adj_date,
          adjust_daily_active_users_test.os,
          adjust_daily_active_users_test.daus,
          adjust_daily_active_users_test.waus,
          adjust_daily_active_users_test.maus,
          adjust_daily_active_users_test.installs,
          adjust_daily_active_users_test.app
SEGMENTED BY hash(adjust_daily_active_users_test.adj_date, adjust_daily_active_users_test.daus, adjust_daily_active_users_test.waus, adjust_daily_active_users_test.maus, adjust_daily_active_users_test.installs, adjust_daily_active_users_test.os, adjust_daily_active_users_test.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.last_updated /*+createtype(L)*/ 
(
 name,
 updated_at,
 updated_by
)
AS
 SELECT last_updated.name,
        last_updated.updated_at,
        last_updated.updated_by
 FROM public.last_updated
 ORDER BY last_updated.name
SEGMENTED BY hash(last_updated.name) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_retention_test /*+createtype(L)*/ 
(
 date,
 os,
 period,
 retention,
 app
)
AS
 SELECT adjust_retention_test.date,
        adjust_retention_test.os,
        adjust_retention_test.period,
        adjust_retention_test.retention,
        adjust_retention_test.app
 FROM public.adjust_retention_test
 ORDER BY adjust_retention_test.date,
          adjust_retention_test.os,
          adjust_retention_test.period,
          adjust_retention_test.retention,
          adjust_retention_test.app
SEGMENTED BY hash(adjust_retention_test.date, adjust_retention_test.period, adjust_retention_test.retention, adjust_retention_test.os, adjust_retention_test.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.copy_adi_dimensional_by_date_s3 /*+createtype(L)*/ 
(
 _year_quarter,
 bl_date,
 product,
 v_prod_major,
 prod_os,
 v_prod_os,
 channel,
 locale,
 continent_code,
 cntry_code,
 tot_requests_on_date,
 distro_name,
 distro_version,
 buildid
)
AS
 SELECT copy_adi_dimensional_by_date_s3._year_quarter,
        copy_adi_dimensional_by_date_s3.bl_date,
        copy_adi_dimensional_by_date_s3.product,
        copy_adi_dimensional_by_date_s3.v_prod_major,
        copy_adi_dimensional_by_date_s3.prod_os,
        copy_adi_dimensional_by_date_s3.v_prod_os,
        copy_adi_dimensional_by_date_s3.channel,
        copy_adi_dimensional_by_date_s3.locale,
        copy_adi_dimensional_by_date_s3.continent_code,
        copy_adi_dimensional_by_date_s3.cntry_code,
        copy_adi_dimensional_by_date_s3.tot_requests_on_date,
        copy_adi_dimensional_by_date_s3.distro_name,
        copy_adi_dimensional_by_date_s3.distro_version,
        copy_adi_dimensional_by_date_s3.buildid
 FROM public.copy_adi_dimensional_by_date_s3
 ORDER BY copy_adi_dimensional_by_date_s3._year_quarter,
          copy_adi_dimensional_by_date_s3.bl_date,
          copy_adi_dimensional_by_date_s3.product,
          copy_adi_dimensional_by_date_s3.v_prod_major,
          copy_adi_dimensional_by_date_s3.prod_os,
          copy_adi_dimensional_by_date_s3.v_prod_os,
          copy_adi_dimensional_by_date_s3.channel,
          copy_adi_dimensional_by_date_s3.locale,
          copy_adi_dimensional_by_date_s3.continent_code,
          copy_adi_dimensional_by_date_s3.cntry_code,
          copy_adi_dimensional_by_date_s3.tot_requests_on_date,
          copy_adi_dimensional_by_date_s3.distro_name,
          copy_adi_dimensional_by_date_s3.distro_version,
          copy_adi_dimensional_by_date_s3.buildid
SEGMENTED BY hash(copy_adi_dimensional_by_date_s3._year_quarter, copy_adi_dimensional_by_date_s3.bl_date, copy_adi_dimensional_by_date_s3.v_prod_major, copy_adi_dimensional_by_date_s3.continent_code, copy_adi_dimensional_by_date_s3.cntry_code, copy_adi_dimensional_by_date_s3.tot_requests_on_date, copy_adi_dimensional_by_date_s3.product, copy_adi_dimensional_by_date_s3.buildid, copy_adi_dimensional_by_date_s3.prod_os, copy_adi_dimensional_by_date_s3.v_prod_os, copy_adi_dimensional_by_date_s3.locale, copy_adi_dimensional_by_date_s3.channel, copy_adi_dimensional_by_date_s3.distro_name, copy_adi_dimensional_by_date_s3.distro_version) ALL NODES KSAFE 1;

CREATE PROJECTION public.test /*+createtype(L)*/ 
(
 id
)
AS
 SELECT test.id
 FROM public.test
 ORDER BY test.id
SEGMENTED BY hash(test.id) ALL NODES KSAFE 1;

CREATE PROJECTION public.opt_dates_unseg_super_node0001 /*+basename(opt_dates_unseg_super)*/ 
(
 date_id,
 year,
 month,
 day_of_year,
 day_of_month,
 day_of_week,
 week_of_year,
 day_of_week_desc,
 day_of_week_short_desc,
 month_desc,
 month_short_desc,
 quarter,
 is_weekday,
 date
)
AS
 SELECT opt_dates.date_id,
        opt_dates.year,
        opt_dates.month,
        opt_dates.day_of_year,
        opt_dates.day_of_month,
        opt_dates.day_of_week,
        opt_dates.week_of_year,
        opt_dates.day_of_week_desc,
        opt_dates.day_of_week_short_desc,
        opt_dates.month_desc,
        opt_dates.month_short_desc,
        opt_dates.quarter,
        opt_dates.is_weekday,
        opt_dates.date
 FROM public.opt_dates
 ORDER BY opt_dates.date_id
UNSEGMENTED ALL NODES;

CREATE PROJECTION public.country_names /*+createtype(L)*/ 
(
 code,
 country
)
AS
 SELECT country_names.code,
        country_names.country
 FROM public.country_names
 ORDER BY country_names.code,
          country_names.country
SEGMENTED BY hash(country_names.code, country_names.country) ALL NODES KSAFE 1;

CREATE PROJECTION public.copy_adi_dimensional_by_date /*+createtype(A)*/ 
(
 _year_quarter,
 bl_date,
 product,
 v_prod_major,
 prod_os,
 v_prod_os,
 channel,
 locale,
 continent_code,
 cntry_code,
 tot_requests_on_date,
 distro_name,
 distro_version,
 buildid
)
AS
 SELECT copy_adi_dimensional_by_date._year_quarter,
        copy_adi_dimensional_by_date.bl_date,
        copy_adi_dimensional_by_date.product,
        copy_adi_dimensional_by_date.v_prod_major,
        copy_adi_dimensional_by_date.prod_os,
        copy_adi_dimensional_by_date.v_prod_os,
        copy_adi_dimensional_by_date.channel,
        copy_adi_dimensional_by_date.locale,
        copy_adi_dimensional_by_date.continent_code,
        copy_adi_dimensional_by_date.cntry_code,
        copy_adi_dimensional_by_date.tot_requests_on_date,
        copy_adi_dimensional_by_date.distro_name,
        copy_adi_dimensional_by_date.distro_version,
        copy_adi_dimensional_by_date.buildid
 FROM public.copy_adi_dimensional_by_date
 ORDER BY copy_adi_dimensional_by_date._year_quarter,
          copy_adi_dimensional_by_date.bl_date,
          copy_adi_dimensional_by_date.channel,
          copy_adi_dimensional_by_date.product,
          copy_adi_dimensional_by_date.v_prod_major,
          copy_adi_dimensional_by_date.locale,
          copy_adi_dimensional_by_date.continent_code,
          copy_adi_dimensional_by_date.cntry_code
SEGMENTED BY hash(copy_adi_dimensional_by_date.tot_requests_on_date) ALL NODES KSAFE 1;

CREATE PROJECTION public.product_channels1_unseg_super_node0004 /*+basename(product_channels1_unseg_super)*/ 
(
 product_channel_id,
 product_channel,
 partner
)
AS
 SELECT product_channels.product_channel_id,
        product_channels.product_channel,
        product_channels.partner
 FROM public.product_channels
 ORDER BY product_channels.product_channel_id,
          product_channels.product_channel,
          product_channels.partner
UNSEGMENTED NODE v_metrics_node0004;

CREATE PROJECTION public.adi_dimensional_by_date_test /*+createtype(L)*/ 
(
 _year_quarter,
 bl_date,
 product,
 v_prod_major,
 prod_os,
 v_prod_os,
 channel,
 locale,
 continent_code,
 cntry_code,
 tot_requests_on_date,
 distro_name,
 distro_version,
 buildid
)
AS
 SELECT adi_dimensional_by_date_test._year_quarter,
        adi_dimensional_by_date_test.bl_date,
        adi_dimensional_by_date_test.product,
        adi_dimensional_by_date_test.v_prod_major,
        adi_dimensional_by_date_test.prod_os,
        adi_dimensional_by_date_test.v_prod_os,
        adi_dimensional_by_date_test.channel,
        adi_dimensional_by_date_test.locale,
        adi_dimensional_by_date_test.continent_code,
        adi_dimensional_by_date_test.cntry_code,
        adi_dimensional_by_date_test.tot_requests_on_date,
        adi_dimensional_by_date_test.distro_name,
        adi_dimensional_by_date_test.distro_version,
        adi_dimensional_by_date_test.buildid
 FROM public.adi_dimensional_by_date_test
 ORDER BY adi_dimensional_by_date_test._year_quarter,
          adi_dimensional_by_date_test.bl_date,
          adi_dimensional_by_date_test.product,
          adi_dimensional_by_date_test.v_prod_major,
          adi_dimensional_by_date_test.prod_os,
          adi_dimensional_by_date_test.v_prod_os,
          adi_dimensional_by_date_test.channel,
          adi_dimensional_by_date_test.locale,
          adi_dimensional_by_date_test.continent_code,
          adi_dimensional_by_date_test.cntry_code,
          adi_dimensional_by_date_test.tot_requests_on_date,
          adi_dimensional_by_date_test.distro_name,
          adi_dimensional_by_date_test.distro_version,
          adi_dimensional_by_date_test.buildid
SEGMENTED BY hash(adi_dimensional_by_date_test._year_quarter, adi_dimensional_by_date_test.bl_date, adi_dimensional_by_date_test.v_prod_major, adi_dimensional_by_date_test.continent_code, adi_dimensional_by_date_test.cntry_code, adi_dimensional_by_date_test.tot_requests_on_date, adi_dimensional_by_date_test.product, adi_dimensional_by_date_test.buildid, adi_dimensional_by_date_test.prod_os, adi_dimensional_by_date_test.v_prod_os, adi_dimensional_by_date_test.locale, adi_dimensional_by_date_test.channel, adi_dimensional_by_date_test.distro_name, adi_dimensional_by_date_test.distro_version) ALL NODES KSAFE 1;

CREATE PROJECTION public.v4_submissionwise_v5 /*+createtype(L)*/ 
(
 submission_date,
 search_provider,
 search_count,
 country,
 locale,
 distribution_id,
 default_provider,
 profiles_matching,
 profile_share,
 intermediate_source
)
AS
 SELECT v4_submissionwise_v5.submission_date,
        v4_submissionwise_v5.search_provider,
        v4_submissionwise_v5.search_count,
        v4_submissionwise_v5.country,
        v4_submissionwise_v5.locale,
        v4_submissionwise_v5.distribution_id,
        v4_submissionwise_v5.default_provider,
        v4_submissionwise_v5.profiles_matching,
        v4_submissionwise_v5.profile_share,
        v4_submissionwise_v5.intermediate_source
 FROM public.v4_submissionwise_v5
 ORDER BY v4_submissionwise_v5.submission_date,
          v4_submissionwise_v5.search_provider,
          v4_submissionwise_v5.search_count,
          v4_submissionwise_v5.country,
          v4_submissionwise_v5.locale,
          v4_submissionwise_v5.distribution_id,
          v4_submissionwise_v5.default_provider,
          v4_submissionwise_v5.profiles_matching,
          v4_submissionwise_v5.profile_share,
          v4_submissionwise_v5.intermediate_source
SEGMENTED BY hash(v4_submissionwise_v5.submission_date, v4_submissionwise_v5.search_count, v4_submissionwise_v5.profiles_matching, v4_submissionwise_v5.profile_share, v4_submissionwise_v5.search_provider, v4_submissionwise_v5.country, v4_submissionwise_v5.locale, v4_submissionwise_v5.distribution_id, v4_submissionwise_v5.default_provider, v4_submissionwise_v5.intermediate_source) ALL NODES KSAFE 1;

CREATE PROJECTION public.mobile_daily_active_users /*+createtype(L)*/ 
(
 app,
 os,
 day,
 dau,
 smooth_dau,
 wau,
 mau,
 weekly_engagement,
 monthly_engagement
)
AS
 SELECT mobile_daily_active_users.app,
        mobile_daily_active_users.os,
        mobile_daily_active_users.day,
        mobile_daily_active_users.dau,
        mobile_daily_active_users.smooth_dau,
        mobile_daily_active_users.wau,
        mobile_daily_active_users.mau,
        mobile_daily_active_users.weekly_engagement,
        mobile_daily_active_users.monthly_engagement
 FROM public.mobile_daily_active_users
 ORDER BY mobile_daily_active_users.app,
          mobile_daily_active_users.os,
          mobile_daily_active_users.day,
          mobile_daily_active_users.dau,
          mobile_daily_active_users.smooth_dau,
          mobile_daily_active_users.wau,
          mobile_daily_active_users.mau,
          mobile_daily_active_users.weekly_engagement,
          mobile_daily_active_users.monthly_engagement
SEGMENTED BY hash(mobile_daily_active_users.day, mobile_daily_active_users.dau, mobile_daily_active_users.smooth_dau, mobile_daily_active_users.wau, mobile_daily_active_users.mau, mobile_daily_active_users.weekly_engagement, mobile_daily_active_users.monthly_engagement, mobile_daily_active_users.app, mobile_daily_active_users.os) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_ios_daily_active_users /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus
)
AS
 SELECT adjust_ios_daily_active_users.adj_date,
        adjust_ios_daily_active_users.daus,
        adjust_ios_daily_active_users.waus,
        adjust_ios_daily_active_users.maus
 FROM public.adjust_ios_daily_active_users
 ORDER BY adjust_ios_daily_active_users.adj_date,
          adjust_ios_daily_active_users.daus,
          adjust_ios_daily_active_users.waus,
          adjust_ios_daily_active_users.maus
SEGMENTED BY hash(adjust_ios_daily_active_users.adj_date, adjust_ios_daily_active_users.daus, adjust_ios_daily_active_users.waus, adjust_ios_daily_active_users.maus) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_focus_daily_active_users /*+createtype(L)*/ 
(
 adj_date,
 daus,
 waus,
 maus,
 installs
)
AS
 SELECT adjust_focus_daily_active_users.adj_date,
        adjust_focus_daily_active_users.daus,
        adjust_focus_daily_active_users.waus,
        adjust_focus_daily_active_users.maus,
        adjust_focus_daily_active_users.installs
 FROM public.adjust_focus_daily_active_users
 ORDER BY adjust_focus_daily_active_users.adj_date,
          adjust_focus_daily_active_users.daus,
          adjust_focus_daily_active_users.waus,
          adjust_focus_daily_active_users.maus
SEGMENTED BY hash(adjust_focus_daily_active_users.adj_date, adjust_focus_daily_active_users.daus, adjust_focus_daily_active_users.waus, adjust_focus_daily_active_users.maus) ALL NODES KSAFE 1;

CREATE PROJECTION public.tmp_search_cohort_churn /*+createtype(L)*/ 
(
 channel,
 geo,
 is_funnelcake,
 acquisition_period,
 start_version,
 sync_usage,
 current_version,
 current_week,
 is_active,
 source,
 medium,
 campaign,
 content,
 distribution_id,
 default_search_engine,
 locale,
 n_profiles,
 usage_hours,
 sum_squared_usage_hours,
 week_start
)
AS
 SELECT tmp_search_cohort_churn.channel,
        tmp_search_cohort_churn.geo,
        tmp_search_cohort_churn.is_funnelcake,
        tmp_search_cohort_churn.acquisition_period,
        tmp_search_cohort_churn.start_version,
        tmp_search_cohort_churn.sync_usage,
        tmp_search_cohort_churn.current_version,
        tmp_search_cohort_churn.current_week,
        tmp_search_cohort_churn.is_active,
        tmp_search_cohort_churn.source,
        tmp_search_cohort_churn.medium,
        tmp_search_cohort_churn.campaign,
        tmp_search_cohort_churn.content,
        tmp_search_cohort_churn.distribution_id,
        tmp_search_cohort_churn.default_search_engine,
        tmp_search_cohort_churn.locale,
        tmp_search_cohort_churn.n_profiles,
        tmp_search_cohort_churn.usage_hours,
        tmp_search_cohort_churn.sum_squared_usage_hours,
        tmp_search_cohort_churn.week_start
 FROM public.tmp_search_cohort_churn
 ORDER BY tmp_search_cohort_churn.channel,
          tmp_search_cohort_churn.geo,
          tmp_search_cohort_churn.is_funnelcake,
          tmp_search_cohort_churn.acquisition_period,
          tmp_search_cohort_churn.start_version,
          tmp_search_cohort_churn.sync_usage,
          tmp_search_cohort_churn.current_version,
          tmp_search_cohort_churn.current_week,
          tmp_search_cohort_churn.is_active,
          tmp_search_cohort_churn.source,
          tmp_search_cohort_churn.medium,
          tmp_search_cohort_churn.campaign,
          tmp_search_cohort_churn.content,
          tmp_search_cohort_churn.distribution_id,
          tmp_search_cohort_churn.default_search_engine,
          tmp_search_cohort_churn.locale,
          tmp_search_cohort_churn.n_profiles,
          tmp_search_cohort_churn.usage_hours,
          tmp_search_cohort_churn.sum_squared_usage_hours,
          tmp_search_cohort_churn.week_start
SEGMENTED BY hash(tmp_search_cohort_churn.geo, tmp_search_cohort_churn.is_funnelcake, tmp_search_cohort_churn.acquisition_period, tmp_search_cohort_churn.current_week, tmp_search_cohort_churn.is_active, tmp_search_cohort_churn.n_profiles, tmp_search_cohort_churn.usage_hours, tmp_search_cohort_churn.sum_squared_usage_hours, tmp_search_cohort_churn.week_start, tmp_search_cohort_churn.start_version, tmp_search_cohort_churn.sync_usage, tmp_search_cohort_churn.current_version, tmp_search_cohort_churn.locale, tmp_search_cohort_churn.channel, tmp_search_cohort_churn.source, tmp_search_cohort_churn.medium, tmp_search_cohort_churn.campaign, tmp_search_cohort_churn.content, tmp_search_cohort_churn.distribution_id, tmp_search_cohort_churn.default_search_engine) ALL NODES KSAFE 1;

CREATE PROJECTION public.adjust_retention /*+createtype(L)*/ 
(
 date,
 os,
 period,
 retention,
 app
)
AS
 SELECT adjust_retention.date,
        adjust_retention.os,
        adjust_retention.period,
        adjust_retention.retention,
        adjust_retention.app
 FROM public.adjust_retention
 ORDER BY adjust_retention.date,
          adjust_retention.os,
          adjust_retention.period,
          adjust_retention.retention,
          adjust_retention.app
SEGMENTED BY hash(adjust_retention.date, adjust_retention.period, adjust_retention.retention, adjust_retention.os, adjust_retention.app) ALL NODES KSAFE 1;

CREATE PROJECTION public.ut_desktop_daily_active_users /*+createtype(L)*/ 
(
 day,
 mau,
 dau,
 smooth_dau,
 engagement_ratio
)
AS
 SELECT ut_desktop_daily_active_users.day,
        ut_desktop_daily_active_users.mau,
        ut_desktop_daily_active_users.dau,
        ut_desktop_daily_active_users.smooth_dau,
        ut_desktop_daily_active_users.engagement_ratio
 FROM public.ut_desktop_daily_active_users
 ORDER BY ut_desktop_daily_active_users.day,
          ut_desktop_daily_active_users.mau,
          ut_desktop_daily_active_users.dau,
          ut_desktop_daily_active_users.smooth_dau,
          ut_desktop_daily_active_users.engagement_ratio
SEGMENTED BY hash(ut_desktop_daily_active_users.day, ut_desktop_daily_active_users.mau, ut_desktop_daily_active_users.dau, ut_desktop_daily_active_users.smooth_dau, ut_desktop_daily_active_users.engagement_ratio) ALL NODES KSAFE 1;


CREATE  VIEW public.adi_dimensional_by_date AS
 SELECT copy_adi_dimensional_by_date._year_quarter,
        copy_adi_dimensional_by_date.bl_date,
        copy_adi_dimensional_by_date.product,
        copy_adi_dimensional_by_date.v_prod_major,
        copy_adi_dimensional_by_date.prod_os,
        copy_adi_dimensional_by_date.v_prod_os,
        copy_adi_dimensional_by_date.channel,
        copy_adi_dimensional_by_date.locale,
        copy_adi_dimensional_by_date.continent_code,
        copy_adi_dimensional_by_date.cntry_code,
        copy_adi_dimensional_by_date.tot_requests_on_date,
        copy_adi_dimensional_by_date.distro_name,
        copy_adi_dimensional_by_date.distro_version
 FROM public.copy_adi_dimensional_by_date;

CREATE  VIEW public.v_ordered_products_old AS
 SELECT products.product_id,
        products.product_guid,
        products.product_name,
        products.product_version,
        products.product_version_major,
        products.product_version_minor,
        products.product_version_minor_suffix,
        products.product_version_sub_a,
        products.product_version_sub_a_suffix,
        products.product_version_sub_b,
        products.product_version_sub_b_suffix,
        products.formatted_version_major,
        CASE products.formatted_version_major WHEN 'Other'::varchar(5) THEN 9990000 WHEN 'Unknown'::varchar(7) THEN 9980000 ELSE ((products.product_version_major * 10000) + products.product_version_minor) END AS NUMERIC_formatted_version_major
 FROM public.products;

CREATE  VIEW public.vw_tableau_adi_daily_old AS
 SELECT adi_dimensional_by_date.bl_date AS ping_date,
        adi_dimensional_by_date.product,
        adi_dimensional_by_date.v_prod_major AS product_version,
        adi_dimensional_by_date.prod_os AS os,
        adi_dimensional_by_date.v_prod_os AS os_version,
        adi_dimensional_by_date.channel,
        adi_dimensional_by_date.locale,
        adi_dimensional_by_date.continent_code,
        l.continent_name,
        adi_dimensional_by_date.cntry_code AS country_code,
        l.country_name,
        adi_dimensional_by_date.distro_name,
        adi_dimensional_by_date.distro_version,
        sum(adi_dimensional_by_date.tot_requests_on_date) AS adi
 FROM (public.adi_dimensional_by_date adi_dimensional_by_date LEFT  JOIN ( SELECT locations.country_code,
        locations.country_name,
        locations.continent_code,
        locations.continent_name
 FROM public.locations
 GROUP BY locations.country_code,
          locations.country_name,
          locations.continent_code,
          locations.continent_name) l ON ((adi_dimensional_by_date.cntry_code = l.country_code)))
 GROUP BY adi_dimensional_by_date.bl_date,
          adi_dimensional_by_date.product,
          adi_dimensional_by_date.v_prod_major,
          adi_dimensional_by_date.prod_os,
          adi_dimensional_by_date.v_prod_os,
          adi_dimensional_by_date.channel,
          adi_dimensional_by_date.locale,
          adi_dimensional_by_date.continent_code,
          l.continent_name,
          adi_dimensional_by_date.cntry_code,
          l.country_name,
          adi_dimensional_by_date.distro_name,
          adi_dimensional_by_date.distro_version;

CREATE  VIEW public.sf_contacts_vw AS
 SELECT sf_contacts.id,
        sf_contacts.created_date,
        CASE WHEN ((sf_contacts.contact_name IS NOT NULL) AND (sf_contacts.contact_name <> '_'::varchar(1))) THEN 1 ELSE 0 END AS has_name,
        CASE WHEN ((sf_contacts.email IS NOT NULL) AND (sf_contacts.email <> '_'::varchar(1))) THEN true ELSE false END AS has_email,
        sf_contacts.email_format,
        sf_contacts.email_language,
        sf_contacts.mailing_country,
        sf_contacts.signup_source_url,
        sf_contacts.double_opt_in,
        sf_contacts.email_opt_out,
        sf_contacts.subscriber,
        CASE WHEN ((sf_contacts.sub_test_pilot = true) OR (sf_contacts.sub_firefox_and_you = true) OR (sf_contacts.sub_firefox_accounts_journey = true)) THEN true ELSE false END AS fx_subscriber,
        sf_contacts.sub_apps_and_hacks AS dev_subscriber,
        sf_contacts.sub_mozilla_foundation AS moz_subscriber,
        CASE WHEN ((sf_contacts.sub_miti_subscriber = true) OR (sf_contacts.sub_mozilla_leadership_network = true) OR (sf_contacts.sub_mozilla_learning_network = true) OR (sf_contacts.sub_webmaker = true) OR (sf_contacts.sub_mozillians_nda = true) OR (sf_contacts.sub_open_innovation_subscriber = true) OR (sf_contacts.sub_test_flight = true) OR (sf_contacts.sub_view_source_global = true) OR (sf_contacts.sub_view_source_namerica = true)) THEN true ELSE false END AS other_subscriber,
        CASE WHEN ((sf_contacts.double_opt_in = true) AND (sf_contacts.email_opt_out = false) AND (sf_contacts.subscriber = true)) THEN 1 ELSE 0 END AS is_active_subscriber
 FROM public.sf_contacts;

CREATE  VIEW public.adjust_daily_active_users_vw AS
(( SELECT adjust_ios_daily_active_users.adj_date,
        adjust_ios_daily_active_users.daus,
        adjust_ios_daily_active_users.waus,
        adjust_ios_daily_active_users.maus,
        'Firefox iOS'::varchar(11) AS type
 FROM public.adjust_ios_daily_active_users UNION  SELECT adjust_android_daily_active_users.adj_date,
        adjust_android_daily_active_users.daus,
        adjust_android_daily_active_users.waus,
        adjust_android_daily_active_users.maus,
        'Firefox Android'::varchar(15) AS type
 FROM public.adjust_android_daily_active_users) UNION  SELECT adjust_klar_daily_active_users.adj_date,
        adjust_klar_daily_active_users.daus,
        adjust_klar_daily_active_users.waus,
        adjust_klar_daily_active_users.maus,
        'Klar'::varchar(4) AS type
 FROM public.adjust_klar_daily_active_users) UNION  SELECT adjust_focus_daily_active_users.adj_date,
        adjust_focus_daily_active_users.daus,
        adjust_focus_daily_active_users.waus,
        adjust_focus_daily_active_users.maus,
        'Focus'::varchar(5) AS type
 FROM public.adjust_focus_daily_active_users;

CREATE FUNCTION public.isOrContains(map Long Varchar, val Varchar)
RETURN boolean AS
BEGIN
RETURN CASE WHEN (public.MapSize(map) <> (-1)) THEN public.MapContainsValue(map, val) ELSE (map = (val)) END;
END;

CREATE FUNCTION v_txtindex.caseInsensitiveNoStemming(x Long Varchar)
RETURN long varchar AS
BEGIN
RETURN lower(x);
END;

CREATE FUNCTION v_txtindex.StemmerCaseInsensitive(v Long Varchar)
RETURN long varchar AS
BEGIN
RETURN v_txtindex.StemmerCaseSensitive(lower(v));
END;

CREATE FUNCTION v_txtindex.Stemmer(v Long Varchar)
RETURN long varchar AS
BEGIN
RETURN v_txtindex.StemmerCaseSensitive(lower(v));
END;

CREATE FUNCTION public.three_steps_bucketing(x Integer, frst_bcks_start Integer, frst_bkts_width Integer, scnd_bcks_start Integer, scnd_bkts_width Integer, thrd_bcks_start Integer, thrd_bkts_width Integer, thrd_bkts_end Integer)
RETURN int AS
BEGIN
RETURN (CASE WHEN (x < frst_bcks_start) THEN frst_bcks_start WHEN (x < scnd_bcks_start) THEN (floor((x / frst_bkts_width)) * frst_bkts_width) WHEN (x < thrd_bcks_start) THEN (floor((x / scnd_bkts_width)) * scnd_bkts_width) WHEN (x < thrd_bkts_end) THEN (floor((x / thrd_bkts_width)) * thrd_bkts_width) ELSE thrd_bkts_end END)::int;
END;

CREATE FUNCTION public.three_steps_bucketing_value(x Integer, frst_bcks_start Integer, frst_bkts_width Integer, scnd_bcks_start Integer, scnd_bkts_width Integer, thrd_bcks_start Integer, thrd_bkts_width Integer, thrd_bkts_end Integer)
RETURN int AS
BEGIN
RETURN (CASE WHEN (x < frst_bcks_start) THEN 0 WHEN (x < scnd_bcks_start) THEN (x / frst_bkts_width) WHEN (x < thrd_bcks_start) THEN (x / scnd_bkts_width) WHEN (x < thrd_bkts_end) THEN (x / scnd_bkts_width) ELSE 0 END)::int;
END;

CREATE FUNCTION public.three_steps_bucketing_width(x Integer, frst_bcks_start Integer, frst_bkts_width Integer, scnd_bcks_start Integer, scnd_bkts_width Integer, thrd_bcks_start Integer, thrd_bkts_width Integer, thrd_bkts_end Integer)
RETURN int AS
BEGIN
RETURN CASE WHEN (x < frst_bcks_start) THEN 1 WHEN (x < scnd_bcks_start) THEN frst_bkts_width WHEN (x < thrd_bcks_start) THEN scnd_bkts_width WHEN (x < thrd_bkts_end) THEN thrd_bkts_width ELSE 1 END;
END;

CREATE FUNCTION public.isnumeric(x Varchar)
RETURN varchar AS
BEGIN
RETURN (regexp_count(x, '^[0-9.-]+$', 1, ''))::varchar;
END;

SELECT MARK_DESIGN_KSAFE(1);


