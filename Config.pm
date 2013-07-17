# --
# Kernel/Config.pm - Config file for OTRS kernel
# Copyright (C) 2001-2010 OTRS AG, http://otrs.org/
# --
# $Id: Config.pm.dist,v 1.23 2010/01/13 22:25:00 martin Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
#  Note:
#
#  -->> OTRS does have a lot of config settings. For more settings
#       (Notifications, Ticket::ViewAccelerator, Ticket::NumberGenerator,
#       LDAP, PostMaster, Session, Preferences, ...) see
#       Kernel/Config/Defaults.pm and copy your wanted lines into "this"
#       config file. This file will not be changed on update!
#
# --

package Kernel::Config;

sub Load {
    my $Self = shift;
    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
    #                                                      #
    #         Start of your own config options!!!          #
    #                                                      #
    # ---------------------------------------------------- #
    # ---------------------------------------------------- #

    # ---------------------------------------------------- #
    # database settings                                    #
    # ---------------------------------------------------- #
    # DatabaseHost
    # (The database host.)
    $Self->{'DatabaseHost'} = 'localhost';
    # Database
    # (The database name.)
    $Self->{'Database'} = 'otrs';
    # DatabaseUser
    # (The database user.)
    $Self->{'DatabaseUser'} = 'otrs';
    # DatabasePw
    # (The password of database user. You also can use bin/otrs.CryptPassword.pl
    # for crypted passwords.)
    $Self->{'DatabasePw'} = 'srto';
    # DatabaseDSN
    # (The database DSN for MySQL ==> more: "man DBD::mysql")
    $Self->{DatabaseDSN} = "DBI:mysql:database=$Self->{Database};host=$Self->{DatabaseHost};";

    # (The database DSN for PostgreSQL ==> more: "man DBD::Pg")
    # if you want to use a local socket connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};";
    # if you want to use a tcpip connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};host=$Self->{DatabaseHost};";

    # ---------------------------------------------------- #
    # fs root directory
    # ---------------------------------------------------- #
    $Self->{Home} = '/opt/otrs';

    # ---------------------------------------------------- #
    # insert your own config settings "here"               #
    # config settings taken from Kernel/Config/Defaults.pm #
use Encode;
    $Self->{TicketAcl}->{'ACL-Name-1'} =
       {
	# these are the properties used for matching ticket etc.
    	 Properties => 
          {
         # match property = all customer tickets
         Frontend =>
              {
              Action => ['CustomerTicketMessage'],
              }
          },
          # return possible options (white list)
          Possible => 
          {
            # possible ticket options. Ticket types available for customer selection has been restricted.  
            #Note - spelling/case must be exact for these variables.
            Ticket => 
            {
            Type =>  ['[RegExp]^.*[^(#)]$'],
    	    },
          },
        };
		
	$Self->{TicketAcl}->{'ACL-Ticket-axy'} = {
		 Properties => {
		  User => {Group_rw => [decode_utf8('АХУ')]},},
		  Possible => {
			Ticket => {
				Type => [decode_utf8('АХУ::Закупка'),decode_utf8('АХУ::Ремонт и обслуживание')],
				#Service => [decode_utf8('АХУ::Мебель'),decode_utf8('АХУ::Сейфы'),decode_utf8('АХУ::Канцтовары и хозтовары'),decode_utf8('АХУ::Бытовая техника'),decode_utf8('АХУ::Ремонтно-строительные работы'),decode_utf8('АХУ::Теплогазоэлектроснабжение и вентиляция'),decode_utf8('АХУ::Мелкий ремонт сантехприборов, электропроводки,жалюзи и т.д.')], 			
			},
		   }, 
		};
		
	$Self->{TicketAcl}->{'ACL-Ticket-not_axy'} = {
		 Properties => {
		  User => {Group_rw => ['not_axy']},},
		  PossibleNot => {
			Ticket => {
				Type => [decode_utf8('АХУ::Закупка'),decode_utf8('АХУ::Ремонт и обслуживание')],
				Service => [decode_utf8('АХУ'),decode_utf8('АХУ::Мебель'),decode_utf8('АХУ::Сейфы'),decode_utf8('АХУ::Канцтовары и хозтовары'),decode_utf8('АХУ::Бытовая техника'),decode_utf8('АХУ::Ремонтно-строительные работы'),decode_utf8('АХУ::Теплогазоэлектроснабжение и вентиляция'),decode_utf8('АХУ::Мелкий ремонт сантехприборов, электропроводки,жалюзи и т.д.'),decode_utf8('АХУ::Сортировка и выдача продукции со склада')], 			
			},
		   },
		};	
		
		
	$Self->{TicketAcl}->{'ACL-Zakupka'} = {
		 Properties => {
 # current type match properties
			Ticket => {
				Type => [decode_utf8('АХУ::Закупка')]  }},
 # return possible options (white list)
		Possible => {
 # possible ticket options (white list)
			Ticket => { 
				Service => [decode_utf8('АХУ::Мебель'),decode_utf8('АХУ::Сейфы'),decode_utf8('АХУ::Канцтовары и хозтовары'),decode_utf8('АХУ::Бытовая техника'),decode_utf8('АХУ::Сортировка и выдача продукции со склада')], 
			},     
		   },
		};
		
	$Self->{TicketAcl}->{'ACL-Remont'} = {
 # match properties
		 Properties => {
 # current type match properties
			Ticket => {
				Type => [decode_utf8('АХУ::Ремонт и обслуживание')]  }},
 # return possible options (white list)
		 Possible => {
 # possible ticket options (white list)
			Ticket => { 
				Service => [decode_utf8('АХУ::Мебель'),decode_utf8('АХУ::Ремонтно-строительные работы'),decode_utf8('АХУ::Бытовая техника'),decode_utf8('АХУ::Сейфы'),decode_utf8('АХУ::Теплогазоэлектроснабжение и вентиляция'),decode_utf8('АХУ::Мелкий ремонт сантехприборов, электропроводки,жалюзи и т.д.')], 
},     
},
}; 
		
###decode_utf8('Тип Запрос::Картридж сервис Печать')
	$Self->{TicketAcl}->{'ACL-CustomerCartrigePrint'} = {
 # match properties
		Properties => {
 # current type match properties
			Ticket => {
				Type => [decode_utf8('Запрос::Картридж')]}},
 # return possible options (white list)
		 Possible => {
 # possible ticket options (white list)
		 Ticket => { 
			Service => [decode_utf8('[RegExp](Печать)$')],
},     
},
};

	# ticket acl
 ###decode_utf8('1-я линия Клиент Банк <-> online, offline')
     $Self->{TicketAcl}->{'ACL-KlientBankfor1stlineKlientBank'} = {
	       # match properties
 # match properties
      Properties => {
 # current type match properties
      Ticket => {
		Queue => [decode_utf8('1-я линия Клиент-Банк')]}},
 # return possible options (white list)
      Possible => {
 # possible ticket options (white list)
      Ticket => { 
         Service => [decode_utf8('Клиент-Банк::E-mail рассылки Клиент-банк КОРПОРАЦИЯ'),decode_utf8('Клиент-Банк::E-mail рассылки Клиент-банк'),decode_utf8('Клиент-Банк::SMS-информатор'),decode_utf8('Клиент-Банк::Голосовая информационно-справочная служба'),decode_utf8('Клиент-Банк::Онлайн КБ'),decode_utf8('Клиент-Банк::Оффлайн КБ')],    
},     
},
};

     $Self->{TicketAcl}->{'ACL-zapros_telephon'} = {
 # match properties
      Properties => {
 # current type match properties
      Ticket => {
        Type => [decode_utf8('Запрос::Изменения в телефонном справочнике')]}},
 # return possible options (white list)
      Possible => {
 # possible ticket options (white list)
      Ticket => { 
		 Service => [decode_utf8('Телефония')],     
},
},
};
		
	$Self->{TicketAcl}->{'ACL-Customer-no_axy_service'} = {
	  Properties => {
      Frontend => {
         Action => ['CustomerTicketMessage'],
         },
      Ticket => {
         Type => [decode_utf8('Запрос'),decode_utf8('Инцидент'),decode_utf8('Запрос::Заблокированная учётная запись'),decode_utf8('Инцидент::Катастрофа'),decode_utf8('Запрос::Установка стандартного ПО'),decode_utf8('Запрос::Получение информации'),decode_utf8('Запрос::Мелкие замены(мышь, клавиатура итп.)')]
        },
      },
   PossibleNot => {
      Ticket => {
		Service => [decode_utf8('АХУ'),decode_utf8('АХУ::Мебель'),decode_utf8('АХУ::Сейфы'),decode_utf8('АХУ::Канцтовары и хозтовары'),decode_utf8('АХУ::Бытовая техника'),decode_utf8('АХУ::Ремонтно-строительные работы'),decode_utf8('АХУ::Теплогазоэлектроснабжение и вентиляция'),decode_utf8('АХУ::Мелкий ремонт сантехприборов, электропроводки,жалюзи и т.д.'),decode_utf8('АХУ::Сортировка и выдача продукции со склада')],
},
},
};
	
	$Self->{TicketAcl}->{'ACL-zapros_Lock_account'} = {
 # match properties
      Properties => {
 # current type match properties
      Ticket => {
         Type => [decode_utf8('Запрос::Заблокирована учётная запись')]   }},
 # return possible options (white list)
      Possible => {
 # possible ticket options (white list)
      Ticket => { 
			Service => [decode_utf8('Доступ в сеть'),decode_utf8('Приложения ОДБ::Минивега'),decode_utf8('Приложения ОДБ::АРМ Кассира'),decode_utf8('Системы денежных переводов::СДП Аверс'),decode_utf8('Системы денежных переводов::СДП Лидер'),decode_utf8('Системы денежных переводов::СДП Юнистрим'),decode_utf8('Электронная почта'),decode_utf8('Системы денежных переводов::СДП Быстрая Почта'),decode_utf8('Системы денежных переводов::СДП ВестернЮнион'),decode_utf8('Системы денежных переводов::СДП Контакт'),decode_utf8('Системы денежных переводов::СДП Маниграмм'),decode_utf8('Системы денежных переводов::СДП Мигом'),decode_utf8('Системы денежных переводов::Единое окно'),],     
	  },
	},
};
	
	$Self->{TicketAcl}->{'ACL-zapros_Lock_account_Customer'} = {
		Properties => {
			Frontend => {
				Action => ['CustomerTicketMessage'],
         },
		Ticket => {
			Type => [decode_utf8('Запрос::Заблокирована учётная запись')]   }},
 # return possible options (white list)
		Possible => {
 # possible ticket options (white list)
		Ticket => { 
			Service => [decode_utf8('Доступ в сеть'),decode_utf8('Приложения ОДБ::Минивега'),decode_utf8('Приложения ОДБ::АРМ Кассира'),decode_utf8('Системы денежных переводов::СДП Аверс'),decode_utf8('Системы денежных переводов::СДП Лидер'),decode_utf8('Системы денежных переводов::СДП Юнистрим'),decode_utf8('Электронная почта'),decode_utf8('Системы денежных переводов::СДП Быстрая Почта'),decode_utf8('Системы денежных переводов::СДП ВестернЮнион'),decode_utf8('Системы денежных переводов::СДП Контакт'),decode_utf8('Системы денежных переводов::СДП Маниграмм'),decode_utf8('Системы денежных переводов::СДП Мигом'),decode_utf8('Системы денежных переводов::Единое окно'),],     
	  },
	},
};

    $Self->{TicketAcl}->{'ACL-RfC#<->Bazoviy_dlya_izmeneniy'} = {
        Properties => {
			Ticket => {
				Type => ['RfC#', decode_utf8('Релизы и развёртывание::Deployment request#')] }},
 # return possible options (white list)
        Possible => {
 # possible ticket options (white list)
			Ticket => { 
				SLA => [decode_utf8('Базовый для Изменений')],     
},
},
};

	$Self->{TicketAcl}->{'ACL-zapros_melkie_zameni<->rabochaya_stanciya'} = {
 # match properties
         Properties => {
 # current type match properties
		    Ticket => {
				Type => [decode_utf8('Запрос::Мелкие замены(мышь, клавиатура итп.)')]}},
 # return possible options (white list)
        Possible => {
 # possible ticket options (white list)
			Ticket => { 
				Service => [decode_utf8('Рабочая станция')],     
},
},
};

	$Self->{TicketAcl}->{'ACL-Financy<->Bazoviy FinOperacii'} = {
 # match properties
         Properties => {
 # current type match properties
		Ticket => {
			Type => [decode_utf8('Финансы#')]}}, 
      Possible => {
 # possible ticket options (white list)
			Ticket => { 
				SLA => [decode_utf8('Базовый ФинОперации')],     
},
},
};

# $Self->{TicketAcl}->{'ACL-NoServiceFinancy<->NoSLABazoviy FinOperacii'} = {    
	 # # match property 
         # Properties => {
     # # current type match properties    
             # Ticket => { 
                 # Type => ['[RegExp]^[^Финансы#]'] }},
     # # return possible options (white list)
            # PossibleNot => {
     # # possible ticket options (white list)
           # Ticket => {
				 # SLA => [decode_utf8('Базовый ФинОперации')],
# },
# },
# };

    $Self->{TicketAcl}->{'ACL-1-st line'} = {
# match properties
		Properties => {
		Ticket => {
			Queue => [decode_utf8('1-я линия Техподдержка')],
			State => ['new'] }},
# return possible options (white list)			 
     Possible => {
		 Action => {
			 AgentTicketMove => 0,
},     
},
};
	
	    $Self->{TicketAcl}->{'ACL-ZablokUhetka<->SecondQueueMinivega'} = {
        Properties => {
			Ticket => {
				Type => [ ^decode_utf8('Запрос::Заблокированная учётная запись')] }},
 # return possible options (white list)
        PossibleNot => {
 # possible ticket options (white list)
			Ticket => { 
				Queue => [decode_utf8('2-я линия Минивега Доступ')],     
},
},
};
    #----------------------------------------------------- #
    # $Self->{SessionUseCookie} = 0;
    $Self->{CheckMXRecord} = 0;
    $Self->{CheckEmailAddresses} = 0;
    # ------------Включаем логирование-------------------- #
    $Self->{LogModule}          = 'Kernel::System::Log::File';
    $Self->{LogModule::LogFile} = '/var/log/otrs.log';
    #-----------------------------------------------------##
# CustomerUser (customer database backend and settings)
    $Self->{CustomerUser1} = {
    Name => 'Database Datasource',
    Module => 'Kernel::System::CustomerUser::DB',
    Params => {
    Table => 'customer_user',
    CaseSensitive => 0,
    },
# customer unique id
    CustomerKey => 'login',
# customer #
    CustomerID => 'customer_id',
    CustomerValid => 'valid_id',
    CustomerUserListFields => ['first_name', 'last_name', 'email'],
    CustomerUserSearchFields => ['login', 'last_name', 'customer_id'],
    CustomerUserSearchPrefix => '',
    CustomerUserSearchSuffix => '*',
    CustomerUserSearchListLimit => 2000,
#    CustomerUserSearchListLimit => 100,
    CustomerUserPostMasterSearchFields => ['email'],
    CustomerUserNameFields => ['title','first_name','last_name'],
    CustomerUserEmailUniqCheck => 1,
#    # show not own tickets in customer panel, CompanyTickets
#    CustomerUserExcludePrimaryCustomerID => 0,
#    # generate auto logins
#    AutoLoginCreation => 0,
#    AutoLoginCreationPrefix => 'auto',
#    # admin can change customer preferences
#    AdminSetPreferences => 1,
#    # cache time to live in sec. - cache any database queries
#    CacheTTL => 0,
#    # just a read only source
#    ReadOnly => 1,
    Map => [
# note: Login, Email and CustomerID needed!
# var, frontend, storage, shown (1=always,2=lite), required, storage-type, http-link, readonly, http-link-target
    [ 'UserTitle',      'Title',      'title',      1, 0, 'var', '', 0 ],
    [ 'UserFirstname',  'Firstname',  'first_name', 1, 1, 'var', '', 0 ],
    [ 'UserLastname',   'Lastname',   'last_name',  1, 1, 'var', '', 0 ],
    [ 'UserLogin',      'Username',   'login',      1, 1, 'var', '', 0 ],
    [ 'UserPassword',   'Password',   'pw',         0, 0, 'var', '', 0 ],
    [ 'UserEmail',      'Email',      'email',      1, 1, 'var', '', 0 ],
    #        [ 'UserEmail',      'Email', 'email',           1, 1, 'var', '$Env{"CGIHandle"}?Action=AgentTicketCompose&ResponseID=1&TicketID=$Data{"TicketID"}&ArticleID=$Data{"ArticleID"}', 0 ],
    [ 'UserCustomerID', 'CustomerID', 'customer_id', 0, 1, 'var', '', 0 ],
    #        [ 'UserCustomerIDs', 'CustomerIDs', 'customer_ids', 1, 0, 'var', '', 0 ],
    [ 'UserPhone',        'Phone',       'phone',        1, 0, 'var', '', 0 ],
    [ 'UserFax',          'Fax',         'fax',          1, 0, 'var', '', 0 ],
    [ 'UserMobile',       'Mobile',      'mobile',       1, 0, 'var', '', 0 ],
    [ 'UserStreet',       'Street',      'street',       1, 0, 'var', '', 0 ],
    [ 'UserZip',          'Zip',         'zip',          1, 0, 'var', '', 0 ],
    [ 'UserCity',         'City',        'city',         1, 0, 'var', '', 0 ],
    [ 'UserCountry',      'Country',     'country',      1, 0, 'var', '', 0 ],
    [ 'UserComment',      'Comment',     'comments',     1, 0, 'var', '', 0 ],
    [ 'ValidID',          'Valid',       'valid_id',     0, 1, 'int', '', 0 ],
    [ 'UserDepartment',   'Dep.',  'department',   1, 0, 'var', '', 0 ],
    [ 'CDBLastComputerName', 'Comp.', 'computer',     1, 0, 'var', '', 0 ]
    ],
# default selections
    Selections => {
    UserTitle => {
    'Mr.' => 'Mr.',
    'Mrs.' => 'Mrs.',
    },
    },
    };

# Authenticate customer users against an LDAP backend  #
     $Self->{CustomerUser2} = {
     Name => 'Active Directory',
     Module => 'Kernel::System::CustomerUser::LDAP',
     Params => {
     Host => '192.168.1.69',
     BaseDN => 'dc=creditdnepr,dc=com',
     SSCOPE => 'sub',
     UserDN => 'cn=servicedesk,cn=Users,dc=creditdnepr,dc=com',
     UserPw => 'servicedeskservicedeskservicedesk',
     AlwaysFilter => '(&(objectcategory=person)(objectclass=user)(mail=*)(!(description=built-In))(!(userAccountControl:1.2.840.113556.1.4.803:=2)))',
     SourceCharset => 'utf-8',
     DestCharset   => 'utf-8',
     },
     ReadOnly => 1,
     CustomerKey => 'sAMAccountName',
     CustomerID => 'mail',
     CustomerUserListFields => ['givenname', 'sn', 'mail'],
     CustomerUserSearchFields => ['displayName','sAMAccountName','givenName', 'sn', 'mail','description'],
     CustomerUserSearchPrefix => '',
     CustomerUserSearchSuffix => '*',
#     CustomerUserSearchListLimit => 100,
#     CustomerUserSearchListLimit => 250,
     CustomerUserSearchListLimit => 2000,
     CustomerUserPostMasterSearchFields => ['displayName','sAMAccountName','givenName','sn','mail','description'],
     CustomerUserNameFields => ['givenname', 'sn'],
     CustomerUserExcludePrimaryCustomerID => 0,
     CacheTTL => 120,
     Map => [
     [ 'UserSalutation', 'Title', 'title', 1, 0, 'var' ],
     [ 'UserFirstname', 'Firstname', 'givenName', 1, 1, 'var' ],
     [ 'UserLastname', 'Lastname', 'sn', 1, 1, 'var' ],
     [ 'UserLogin', 'Login', 'sAMAccountName', 1, 1, 'var' ],
     [ 'UserEmail', 'Email', 'mail', 1, 1, 'var' ],
     [ 'UserCustomerID', 'CustomerID', 'mail', 0, 1, 'var' ],
     [ 'UserPhone', 'Phone', 'telephoneNumber', 1, 0, 'var' ],
     [ 'UserAddress', 'Address', 'postalAddress', 1, 0, 'var' ],
     [ 'UserStreet', 'Street', 'streetAddress', 1, 0, 'var' ],
     [ 'UserCity', 'City', 'l', 1, 0, 'var' ],
     [ 'UserZip', 'ZIP', 'postalCode', 1, 0, 'var' ],
     [ 'UserCountry', 'Country', 'co', 1, 0, 'var' ],
     [ 'UserComment', 'Comment', 'wWWHomePage', 1, 0, 'var' ],
     [ 'UserDepartment', 'Dep.', 'department', 1, 0, 'var' ],
     [ 'CDBLastComputerName',  'Comp.', 'computer',     1, 0, 'var' ]
     ],
   };
   $Self->{'Customer::AuthModule'} = 'Kernel::System::CustomerAuth::LDAP';
   $Self->{'Customer::AuthModule::LDAP::Host'} = '192.168.1.69';
   $Self->{'Customer::AuthModule::LDAP::BaseDN'} = 'DC=creditdnepr,DC=com';
   $Self->{'Customer::AuthModule::LDAP::UID'} = 'sAMAccountName';
   $Self->{'Customer::AuthModule::LDAP::SearchUserDN'} = 'cn=servicedesk,cn=Users,dc=creditdnepr,dc=com'; 
   $Self->{'Customer::AuthModule::LDAP::SearchUserPw'} = 'servicedeskservicedeskservicedesk';

########################################################################################################
# This is an example configuration for an LDAP auth. backend.
# (Make sure Net::LDAP is installed!)

$Self->{'AuthModule'} = 'Kernel::System::Auth::LDAP';
$Self->{'AuthModule::UseSyncBackend'} = 'AuthSyncBackend';
$Self->{'AuthModule::LDAP::Host'} = '192.168.1.69';
$Self->{'AuthModule::LDAP::BaseDN'} = 'dc=creditdnepr,dc=com';
$Self->{'AuthModule::LDAP::UID'} = 'sAMAccountName';

# Check if the user is allowed to auth in a posixGroup
# (e. g. user needs to be in a group xyz to use otrs)
$Self->{'AuthModule::LDAP::GroupDN'} = 'CN=otrsagents,CN=Users,DC=creditdnepr,DC=com';
$Self->{'AuthModule::LDAP::AccessAttr'} = 'member';
# for ldap posixGroups objectclass (just uid)
#  $Self->{'AuthModule::LDAP::UserAttr'} = 'UID';
# for non ldap posixGroups objectclass (with full user dn)
$Self->{'AuthModule::LDAP::UserAttr'} = 'DN';

# The following is valid but would only be necessary if the
# anonymous user do NOT have permission to read from the LDAP tree
$Self->{'AuthModule::LDAP::SearchUserDN'} = 'CN=servicedesk,CN=Users,DC=creditdnepr,DC=com';
$Self->{'AuthModule::LDAP::SearchUserPw'} = 'servicedeskservicedeskservicedesk';

# in case you want to add always one filter to each ldap query, use
# this option. e. g. AlwaysFilter => '(mail=*)' or AlwaysFilter => '(objectclass=user)'
$Self->{'AuthModule::LDAP::AlwaysFilter'} = '(&(objectCategory=Person)(objectClass=user)(description=*OTRS*))';

# in case you want to add a suffix to each login name, then
# you can use this option. e. g. user just want to use user but
# in your ldap directory exists user@domain.
#    $Self->{'AuthModule::LDAP::UserSuffix'} = '@creditdnepr.com';

# Net::LDAP new params (if needed - for more info see perldoc Net::LDAP)
$Self->{'AuthModule::LDAP::Params'} = {
    port => 389,
        timeout => 120,
            async => 0,
                version => 3,
                };
##########################################################################################
# Создание пользователя в локальной базе OTRS в случае успешно выполненого логина в OTRS
$Self->{'AuthSyncModule'} = 'Kernel::System::Auth::Sync::LDAP';
# Определение LDAP сервера
$Self->{'AuthSyncModule::LDAP::Host'} = '192.168.1.20';

# Если Вы внимательно читали выше, то тут все понятно 
$Self->{'AuthSyncModule::LDAP::BaseDN'} = 'dc=creditdnepr,dc=com';
$Self->{'AuthSyncModule::LDAP::UID'} = 'sAMAccountName';
$Self->{'AuthSyncModule::LDAP::SearchUserDN'} = 'CN=servicedesk,CN=Users,DC=creditdnepr,DC=com';
$Self->{'AuthSyncModule::LDAP::SearchUserPw'} = 'servicedeskservicedeskservicedesk';

# DB -> LDAP - соспостоавление полей в локальной базе OTRS и атрибутов пользователя
$Self->{'AuthSyncModule::LDAP::UserSyncMap'} = {
UserFirstname => 'givenName',
UserLastname => 'sn',
UserEmail => 'mail',
};
#####################################################################
# In case you need to use OTRS in iso-charset, you can define this
# by using this option (converts utf-8 data from LDAP to iso).
$Self->{'AuthSyncModule::LDAP::Charset'} = 'utf-8';

# Net::LDAP new params (if needed - for more info see perldoc Net::LDAP)
$Self->{'AuthSyncModule::LDAP::Params'} = {
port => 389,
timeout => 120,
async => 0,
version => 3,
};

# Die if backend can't work, e. g. can't connect to server.
# $Self->{'AuthSyncModule::LDAP::Die'} = 1;

# Attributes needed for group syncs
# (attribute name for group value key)
# $Self->{'AuthSyncModule::LDAP::AccessAttr'} = 'memberUid';
# (attribute for type of group content UID/DN for full ldap name)
# $Self->{'AuthSyncModule::LDAP::UserAttr'} = 'UID';
# $Self->{'AuthSyncModule::LDAP::UserAttr'} = 'DN';

# AuthSyncModule::LDAP::UserSyncInitialGroups
# (sync following group with rw permission after initial create of first agent login) - включаем в следующие группы с полными правами
$Self->{'AuthSyncModule::LDAP::UserSyncInitialGroups'} = [
#'admin', 'faq', 'faq_admin', 'faq_approval', 'itsm-change', 'itsm-change-builder', 'itsm-change-manager', 'itsm-configitem', 'itsm-service', 'stats', 'users'
#'faq', 'users'
];
##########################################################################################
# This is an example configuration for an apache ($ENV{REMOTE_USER})
# auth. backend. Use it if you want to have a singe login through
# apache http-basic-auth
#$Self->{'AuthModule'} = 'Kernel::System::Auth::HTTPBasicAuth';

# Note:
#
# If you use this module, you should use as fallback
# the following configuration settings if the user is not authorized
# apache ($ENV{REMOTE_USER})
#$Self->{LoginURL} = 'http://host.example.com/not-authorised-for-otrs.html';
#$Self->{LogoutURL} = 'http://host.example.com/thanks-for-using-otrs.html';
#Index
$Self->{'AuthModule'} = 'Kernel::System::Auth::HTTPBasicAuth';
$Self->{LoginURL} = 'http://otrs.creditdnepr.com/otrs/index.pl';
$Self->{LogoutURL} = 'http://otrs.creditdnepr.com/otrs/index.pl';
#$Self->{LoginURL} = 'http://192.168.1.27/otrs/index.pl';
#$Self->{LogoutURL} = 'http://192.168.1.27/otrs/index.pl';
#
$Self->{'Customer::AuthModule'} = 'Kernel::System::Auth::HTTPBasicAuth';
$Self->{CustomerPanelLoginURL} = 'http://otrs.creditdnepr.com/otrs/customer.pl';
$Self->{CustomerPanelLogoutURL} = 'http://otrs.creditdnepr.com/otrs/customer.pl';
#$Self->{CustomerPanelLoginURL} = 'http://192.168.1.27/otrs/customer.pl';
#$Self->{CustomerPanelLogoutURL} = 'http://192.168.1.27/otrs/customer.pl';



#############################################################
    # ---------------------------------------------------- #
    # data inserted by installer                           #
    # ---------------------------------------------------- #
    # $DIBI$
    $Self->{'DefaultCharset'} = 'utf-8';

    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
    #                                                      #
    #           End of your own config options!!!          #
    #                                                      #
    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
}

# ---------------------------------------------------- #
# needed system stuff (don't edit this)                #
# ---------------------------------------------------- #
use strict;
use warnings;

use vars qw(@ISA $VERSION);
$VERSION = qw($Revision: 1.23 $)[1];

use Kernel::Config::Defaults;
push (@ISA, 'Kernel::Config::Defaults');

# -----------------------------------------------------#

1;
