$PBExportHeader$n_cst_wininet.sru
forward
global type n_cst_wininet from nonvisualobject
end type
end forward

type FileTime from structure
	ulong		LowDateTime
	ulong		HighDateTime
end type

type WIN32_FIND_DATA from structure
	unsignedlong		fileattributes
	filetime		creationtime
	filetime		lastaccesstime
	filetime		lastwritetime
	unsignedlong		filesizehigh
	unsignedlong		filesizelow
	unsignedlong		reserved0
	unsignedlong		reserved1
	character		filename[260]
	character		alternatefilename[14]
end type

global type n_cst_wininet from nonvisualobject autoinstantiate
end type

type prototypes
Function boolean InternetAutodial (ulong  dwFlags, ulong hWndParent) Library "WININET.DLL"
Function boolean InternetAutodialHangup (ulong dwReserved) Library "WININET.DLL"
Function boolean InternetCloseHandle (ulong hInternet) Library "WININET.DLL"
Function ulong InternetConnect (ulong hInternet, ref string lpszServerName, long nServerPort, ref string lpszUserName, ref string lpszPassword, ulong dwService, ulong dwFlags, ref ulong dwContext) Library "WININET.DLL" Alias for "InternetConnectA;Ansi"
Function ulong InternetDial (ulong hWndParent, ref string lpszConnectoid, ulong dwFlags, ref ulong lpdwConnection, ulong dwReserved) Library "WININET.DLL" alias for "InternetDial;Ansi"
Function ulong InternetGetConnectedState (ref ulong lpdwFlags, ulong dwReserved) Library "WININET.DLL"
Function ulong InternetGetLastResponseInfo (ref ulong lpdwError, ref string lpszBuffer, ref ulong lpdwBufferLength) Library "WININET.DLL" Alias for "InternetGetLastResponseInfoA;Ansi"
Function ulong InternetHangUp (ulong dwConnection, ulong dwReserved) Library "WININET.DLL"
Function ulong InternetOpen (ref string lpszAgent, ulong dwAccessType, ref string lpszProxy, ref string lpszProxyBypass, ulong dwFlags) Library "WININET.DLL" Alias for "InternetOpenA;Ansi"
Function ulong InternetQueryDataAvailable (ulong hFile, ref ulong lpdwNumberOfBytesAvailable, ulong dwFlags, ulong dwContext) Library "WININET.DLL"
Function boolean InternetSetOption (ulong hInternet, ulong dwOption,ref string lpBuffer, ulong dwBufferLength) Library "WININET.DLL" Alias for "InternetSetOptionA;Ansi"
Function ulong InternetOpenUrl (ulong hInternet, ref string lpszUrl, ref string lpszHeaders, ulong dwHeadersLength, ulong dwFlags, ref ulong dwContext) Library "WININET.DLL" Alias for "InternetOpenUrlA;Ansi"
Function ulong InternetReadFile (ulong hFile, ref string lpBuffer, ulong dwNumberOfBytesToRead, ref ulong lpdwNumberOfBytesRead) Library "WININET.DLL" alias for "InternetReadFile;Ansi"
Function boolean InternetCheckConnection (string lpszUrl, ulong dwFlags, ulong dwReserved) Library "WININET.DLL" Alias for "InternetCheckConnectionA;Ansi"
Function ulong FtpFindFirstFile (ulong hConnect, ref string lpszSearchFile, ref WIN32_FIND_DATA lpFindFileData, ulong dwFlags, ref ulong dwContext) Library "WININET.DLL" Alias for "FtpFindFirstFileA;Ansi"
Function boolean FtpGetFile (ulong hConnect, ref string lpszRemoteFile, ref string lpszNewFile, boolean fFailIfExists, ulong dwFlagsAndAttributes,  ulong dwFlags, ref ulong dwContext) Library "WININET.DLL" Alias for "FtpGetFileA;Ansi"
Function boolean FtpPutFile (ulong hConnect, ref string lpszLocalFile, ref string lpszNewRemoteFile, ulong dwFlags, ref ulong dwContext) Library "WININET.DLL" Alias for "FtpPutFileA;Ansi"
Function boolean FtpDeleteFile (ulong hConnect, ref string lpszFileName) Library "WININET.DLL" Alias for "FtpDeleteFileA;Ansi"
Function boolean FtpRenameFile (ulong hConnect, ref string lpszExisting, ref string lpszNew)  Library "WININET.DLL" Alias for "FtpRenameFileA;Ansi"
Function ulong FtpOpenFile (ulong hConnect, ref string lpszFileName, ulong dwAccess, ulong dwFlags, ref ulong dwContext) Library "WININET.DLL" Alias for "FtpOpenFileA;Ansi"
Function boolean FtpCreateDirectory (ulong hConnect, ref string lpszDirectory) Library "WININET.DLL" Alias for "FtpCreateDirectoryA;Ansi"
Function boolean FtpRemoveDirectory (ulong hConnect, ref string lpszDirectory) Library "WININET.DLL" Alias for "FtpRemoveDirectoryA;Ansi"
Function boolean FtpSetCurrentDirectory (ulong hConnect, ref string lpszDirectory) Library "WININET.DLL" Alias for "FtpSetCurrentDirectoryA;Ansi"
Function boolean FtpGetCurrentDirectory (ulong hConnect, ref string lpszCurrentDirectory, ref ulong lpdwCurrentDirectory) Library "WININET.DLL" Alias for "FtpGetCurrentDirectoryA;Ansi"
Function boolean FtpCommand (ulong hConnect, boolean fExpectResponse, ulong dwFlags, ref string lpszCommand, ref ulong dwContex, ref ulong phFtpCommand) Library "WININET.DLL" Alias for "FtpCommandA;Ansi"
Function boolean InternetFindNextFile (ulong hFind, ref WIN32_FIND_DATA lpvFindData) Library "WININET.DLL" Alias for "InternetFindNextFileA;Ansi"
Function ulong HttpOpenRequest (ulong hConnect, ref string lpszVerb, ref string lpszObjectName, ref string lpszVersion, ref string lpszReferrer, ref string lplpszAcceptTypes[], ulong dwFlags, ref ulong dwContext) Library "WININET.DLL" Alias for "HttpOpenRequestA;Ansi"
Function ulong HttpSendRequest (ulong hRequest, ref string lpszHeaders, ulong dwHeadersLength, ref string lpOptional, ulong dwOptionalLength) Library "WININET.DLL" Alias for "HttpSendRequestA;Ansi"
Function boolean HttpQueryInfo (ulong  hRequest, ulong dwInfoLevel, ref string lpvBuffer, ref ulong lpdwBufferLength, ref ulong lpdwIndex ) LIBRARY "wininet.dll" Alias for "HttpQueryInfoA;Ansi"

end prototypes

type variables
Public:

// Internet connection flags
CONSTANT uint CONNECTION_MODEM	= 1
CONSTANT uint CONNECTION_LAN		= 2
CONSTANT uint CONNECTION_PROXY	= 4
CONSTANT uint CONNECTION_MODEM_BUSY	= 8
CONSTANT ulong INTERNET_FLAG_ASYNC	= 268435456
CONSTANT ulong INTERNET_FLAG_SECURE	= 8388608

// Internet auto-dial flags
CONSTANT uint AUTODIAL_FORCE_ONLINE		= 1
CONSTANT uint AUTODIAL_FORCE_UNATTENDED	= 2
CONSTANT uint AUTODIAL_FAILIFSECURITYCHECK	= 4

// Internet dial flags
CONSTANT uint INTERNET_DIAL_UNATTENDED	= 32768

// Internet open flags
CONSTANT uint INTERNET_OPEN_TYPE_PRECONFIG	= 0
CONSTANT uint INTERNET_OPEN_TYPE_DIRECT	= 1
CONSTANT uint INTERNET_OPEN_TYPE_GATEWAY	= 2
CONSTANT uint INTERNET_OPEN_TYPE_PROXY		= 3

// Ports
CONSTANT uint INTERNET_INVALID_PORT_NUMBER	= 0
CONSTANT uint INTERNET_DEFAULT_FTP_PORT	= 21
CONSTANT uint INTERNET_DEFAULT_GOPHER_PORT	= 70
CONSTANT uint INTERNET_DEFAULT_HTTP_PORT	= 80
CONSTANT uint INTERNET_DEFAULT_HTTPS_PORT	= 443
CONSTANT uint INTERNET_DEFAULT_SOCKS_PORT	= 1080

// Service/Command types
CONSTANT uint INTERNET_SERVICE_FTP	= 1
CONSTANT uint INTERNET_SERVICE_GOPHER	= 2
CONSTANT uint INTERNET_SERVICE_HTTP	= 3

// Internet flags
CONSTANT ulong INTERNET_FLAG_RELOAD			= 2147483648
CONSTANT ulong INTERNET_FLAG_NO_CACJE_WRITE		= 67108864
CONSTANT ulong INTERNET_FLAG_RAW_DATA		= 1073741824

// protocol-specific flags:
constant ulong	 INTERNET_FLAG_PASSIVE = 134217728 // used for FTP connections

CONSTANT ulong  	FTP_TRANSFER_TYPE_UNKNOWN = 0
CONSTANT ulong  	FTP_TRANSFER_TYPE_ASCII = 1
CONSTANT ulong  	FTP_TRANSFER_TYPE_BINARY = 2
CONSTANT ulong  	FTP_TRANSFER_TYPE_MASK = 3

// Error messages
CONSTANT uint ERROR_NO_MORE_FILES			= 18
CONSTANT uint INTERNET_ERROR_BASE			= 12000
CONSTANT uint ERROR_INTERNET_OUT_OF_HANDLES		= (INTERNET_ERROR_BASE + 1)
CONSTANT uint ERROR_INTERNET_TIMEOUT			= (INTERNET_ERROR_BASE + 2)
CONSTANT uint ERROR_INTERNET_EXTENDED_ERROR		= (INTERNET_ERROR_BASE + 3)
CONSTANT uint ERROR_INTERNET_INTERNAL_ERROR		= (INTERNET_ERROR_BASE + 4)
CONSTANT uint ERROR_INTERNET_INVALID_URL			= (INTERNET_ERROR_BASE + 5)
CONSTANT uint ERROR_INTERNET_UNRECOGNIZED_SCHEME	= (INTERNET_ERROR_BASE + 6)
CONSTANT uint ERROR_INTERNET_NAME_NOT_RESOLVED	= (INTERNET_ERROR_BASE + 7)
CONSTANT uint ERROR_INTERNET_PROTOCOL_NOT_FOUND	= (INTERNET_ERROR_BASE + 8)
CONSTANT uint ERROR_INTERNET_INVALID_OPTION		= (INTERNET_ERROR_BASE + 9)
CONSTANT uint ERROR_INTERNET_BAD_OPTION_LENGTH        	= (INTERNET_ERROR_BASE + 10)
CONSTANT uint ERROR_INTERNET_OPTION_NOT_SETTABLE      	= (INTERNET_ERROR_BASE + 11)
CONSTANT uint ERROR_INTERNET_SHUTDOWN                 		= (INTERNET_ERROR_BASE + 12)
CONSTANT uint ERROR_INTERNET_INCORRECT_USER_NAME      	= (INTERNET_ERROR_BASE + 13)
CONSTANT uint ERROR_INTERNET_INCORRECT_PASSWORD       	= (INTERNET_ERROR_BASE + 14)
CONSTANT uint ERROR_INTERNET_LOGIN_FAILURE            		= (INTERNET_ERROR_BASE + 15)
CONSTANT uint ERROR_INTERNET_INVALID_OPERATION        	= (INTERNET_ERROR_BASE + 16)
CONSTANT uint ERROR_INTERNET_OPERATION_CANCELLED      	= (INTERNET_ERROR_BASE + 17)
CONSTANT uint ERROR_INTERNET_INCORRECT_HANDLE_TYPE    	= (INTERNET_ERROR_BASE + 18)
CONSTANT uint ERROR_INTERNET_INCORRECT_HANDLE_STATE   	= (INTERNET_ERROR_BASE + 19)
CONSTANT uint ERROR_INTERNET_NOT_PROXY_REQUEST        	= (INTERNET_ERROR_BASE + 20)
CONSTANT uint ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND	= (INTERNET_ERROR_BASE + 21)
CONSTANT uint ERROR_INTERNET_BAD_REGISTRY_PARAMETER   	= (INTERNET_ERROR_BASE + 22)
CONSTANT uint ERROR_INTERNET_NO_DIRECT_ACCESS         	= (INTERNET_ERROR_BASE + 23)
CONSTANT uint ERROR_INTERNET_NO_CONTEXT               		= (INTERNET_ERROR_BASE + 24)
CONSTANT uint ERROR_INTERNET_NO_CALLBACK              		= (INTERNET_ERROR_BASE + 25)
CONSTANT uint ERROR_INTERNET_REQUEST_PENDING          	= (INTERNET_ERROR_BASE + 26)
CONSTANT uint ERROR_INTERNET_INCORRECT_FORMAT         	= (INTERNET_ERROR_BASE + 27)
CONSTANT uint ERROR_INTERNET_ITEM_NOT_FOUND           	= (INTERNET_ERROR_BASE + 28)
CONSTANT uint ERROR_INTERNET_CANNOT_CONNECT           	= (INTERNET_ERROR_BASE + 29)
CONSTANT uint ERROR_INTERNET_CONNECTION_ABORTED       	= (INTERNET_ERROR_BASE + 30)
CONSTANT uint ERROR_INTERNET_CONNECTION_RESET         	= (INTERNET_ERROR_BASE + 31)
CONSTANT uint ERROR_INTERNET_FORCE_RETRY              		= (INTERNET_ERROR_BASE + 32)
CONSTANT uint ERROR_INTERNET_INVALID_PROXY_REQUEST    	= (INTERNET_ERROR_BASE + 33)
CONSTANT uint ERROR_INTERNET_NEED_UI                  		= (INTERNET_ERROR_BASE + 34)
CONSTANT uint ERROR_INTERNET_HANDLE_EXISTS            		= (INTERNET_ERROR_BASE + 36)
CONSTANT uint ERROR_INTERNET_SEC_CERT_DATE_INVALID    	= (INTERNET_ERROR_BASE + 37)
CONSTANT uint ERROR_INTERNET_SEC_CERT_CN_INVALID      	= (INTERNET_ERROR_BASE + 38)
CONSTANT uint ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR   	= (INTERNET_ERROR_BASE + 39)
CONSTANT uint ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR   	= (INTERNET_ERROR_BASE + 40)
CONSTANT uint ERROR_INTERNET_MIXED_SECURITY           		= (INTERNET_ERROR_BASE + 41)
CONSTANT uint ERROR_INTERNET_CHG_POST_IS_NON_SECURE   	= (INTERNET_ERROR_BASE + 42)
CONSTANT uint ERROR_INTERNET_POST_IS_NON_SECURE       	= (INTERNET_ERROR_BASE + 43)
CONSTANT uint ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED  	= (INTERNET_ERROR_BASE + 44)
CONSTANT uint ERROR_INTERNET_INVALID_CA               		= (INTERNET_ERROR_BASE + 45)
CONSTANT uint ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP    	= (INTERNET_ERROR_BASE + 46)
CONSTANT uint ERROR_INTERNET_ASYNC_THREAD_FAILED      	= (INTERNET_ERROR_BASE + 47)
CONSTANT uint ERROR_INTERNET_REDIRECT_SCHEME_CHANGE   	= (INTERNET_ERROR_BASE + 48)
CONSTANT uint ERROR_INTERNET_DIALOG_PENDING           		= (INTERNET_ERROR_BASE + 49)
CONSTANT uint ERROR_INTERNET_RETRY_DIALOG             		= (INTERNET_ERROR_BASE + 50)
CONSTANT uint ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR  	= (INTERNET_ERROR_BASE + 52)
CONSTANT uint ERROR_INTERNET_INSERT_CDROM             		= (INTERNET_ERROR_BASE + 53)
CONSTANT uint ERROR_FTP_TRANSFER_IN_PROGRESS          	= (INTERNET_ERROR_BASE + 110)
CONSTANT uint ERROR_FTP_DROPPED                       		= (INTERNET_ERROR_BASE + 111)
CONSTANT uint ERROR_FTP_NO_PASSIVE_MODE               		= (INTERNET_ERROR_BASE + 112)
CONSTANT uint ERROR_GOPHER_PROTOCOL_ERROR             	= (INTERNET_ERROR_BASE + 130)
CONSTANT uint ERROR_GOPHER_NOT_FILE                   		= (INTERNET_ERROR_BASE + 131)
CONSTANT uint ERROR_GOPHER_DATA_ERROR                 		= (INTERNET_ERROR_BASE + 132)
CONSTANT uint ERROR_GOPHER_END_OF_DATA                		= (INTERNET_ERROR_BASE + 133)
CONSTANT uint ERROR_GOPHER_INVALID_LOCATOR            		= (INTERNET_ERROR_BASE + 134)
CONSTANT uint ERROR_GOPHER_INCORRECT_LOCATOR_TYPE     	= (INTERNET_ERROR_BASE + 135)
CONSTANT uint ERROR_GOPHER_NOT_GOPHER_PLUS            	= (INTERNET_ERROR_BASE + 136)
CONSTANT uint ERROR_GOPHER_ATTRIBUTE_NOT_FOUND        	= (INTERNET_ERROR_BASE + 137)
CONSTANT uint ERROR_GOPHER_UNKNOWN_LOCATOR            	= (INTERNET_ERROR_BASE + 138)
CONSTANT uint ERROR_HTTP_HEADER_NOT_FOUND             	= (INTERNET_ERROR_BASE + 150)
CONSTANT uint ERROR_HTTP_DOWNLEVEL_SERVER             	= (INTERNET_ERROR_BASE + 151)
CONSTANT uint ERROR_HTTP_INVALID_SERVER_RESPONSE      	= (INTERNET_ERROR_BASE + 152)
CONSTANT uint ERROR_HTTP_INVALID_HEADER               		= (INTERNET_ERROR_BASE + 153)
CONSTANT uint ERROR_HTTP_INVALID_QUERY_REQUEST        	= (INTERNET_ERROR_BASE + 154)
CONSTANT uint ERROR_HTTP_HEADER_ALREADY_EXISTS        	= (INTERNET_ERROR_BASE + 155)
CONSTANT uint ERROR_HTTP_REDIRECT_FAILED              		= (INTERNET_ERROR_BASE + 156)
CONSTANT uint ERROR_HTTP_NOT_REDIRECTED               		= (INTERNET_ERROR_BASE + 160)
CONSTANT uint ERROR_HTTP_COOKIE_NEEDS_CONFIRMATION    	= (INTERNET_ERROR_BASE + 161)
CONSTANT uint ERROR_HTTP_COOKIE_DECLINED              		= (INTERNET_ERROR_BASE + 162)
CONSTANT uint ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION  	= (INTERNET_ERROR_BASE + 168)
CONSTANT uint ERROR_INTERNET_SECURITY_CHANNEL_ERROR   	= (INTERNET_ERROR_BASE + 157)
CONSTANT uint ERROR_INTERNET_UNABLE_TO_CACHE_FILE     	= (INTERNET_ERROR_BASE + 158)
CONSTANT uint ERROR_INTERNET_TCPIP_NOT_INSTALLED      	= (INTERNET_ERROR_BASE + 159)
CONSTANT uint ERROR_INTERNET_DISCONNECTED             		= (INTERNET_ERROR_BASE + 163)
CONSTANT uint ERROR_INTERNET_SERVER_UNREACHABLE       	= (INTERNET_ERROR_BASE + 164)
CONSTANT uint ERROR_INTERNET_PROXY_SERVER_UNREACHABLE 	= (INTERNET_ERROR_BASE + 165)
CONSTANT uint ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT    		= (INTERNET_ERROR_BASE + 166)
CONSTANT uint ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT 	= (INTERNET_ERROR_BASE + 167)
CONSTANT uint ERROR_INTERNET_SEC_INVALID_CERT    		= (INTERNET_ERROR_BASE + 169)
CONSTANT uint ERROR_INTERNET_SEC_CERT_REVOKED    	= (INTERNET_ERROR_BASE + 170)
CONSTANT uint ERROR_INTERNET_FAILED_DUETOSECURITYCHECK	= (INTERNET_ERROR_BASE + 171)
CONSTANT uint INTERNET_ERROR_LAST                       		= ERROR_INTERNET_FAILED_DUETOSECURITYCHECK

//
// HttpQueryInfo info levels. Generally, there is one info level
// for each potential RFC822/HTTP/MIME header that an HTTP server
// may send as part of a request response.
//
// The HTTP_QUERY_RAW_HEADERS info level is provided for clients
// that choose to perform their own header parsing.
//


constant ulong HTTP_QUERY_MIME_VERSION                 = 0
constant ulong HTTP_QUERY_CONTENT_TYPE                 = 1
constant ulong HTTP_QUERY_CONTENT_TRANSFER_ENCODING    = 2
constant ulong HTTP_QUERY_CONTENT_ID                   = 3
constant ulong HTTP_QUERY_CONTENT_DESCRIPTION          = 4
constant ulong HTTP_QUERY_CONTENT_LENGTH               = 5
constant ulong HTTP_QUERY_CONTENT_LANGUAGE             = 6
constant ulong HTTP_QUERY_ALLOW                        = 7
constant ulong HTTP_QUERY_PUBLIC                       = 8
constant ulong HTTP_QUERY_DATE                         = 9
constant ulong HTTP_QUERY_EXPIRES                      = 10
constant ulong HTTP_QUERY_LAST_MODIFIED                = 11
constant ulong HTTP_QUERY_MESSAGE_ID                   = 12
constant ulong HTTP_QUERY_URI                          = 13
constant ulong HTTP_QUERY_DERIVED_FROM                 = 14
constant ulong HTTP_QUERY_COST                         = 15
constant ulong HTTP_QUERY_LINK                         = 16
constant ulong HTTP_QUERY_PRAGMA                       = 17
constant ulong HTTP_QUERY_VERSION                      = 18  // special: part of status line
constant ulong HTTP_QUERY_STATUS_CODE                  = 19  // special: part of status line
constant ulong HTTP_QUERY_STATUS_TEXT                  = 20  // special: part of status line
constant ulong HTTP_QUERY_RAW_HEADERS                  = 21  // special: all headers as ASCIIZ
constant ulong HTTP_QUERY_RAW_HEADERS_CRLF             = 22  // special: all headers
constant ulong HTTP_QUERY_CONNECTION                   = 23
constant ulong HTTP_QUERY_ACCEPT                       = 24
constant ulong HTTP_QUERY_ACCEPT_CHARSET               = 25
constant ulong HTTP_QUERY_ACCEPT_ENCODING              = 26
constant ulong HTTP_QUERY_ACCEPT_LANGUAGE              = 27
constant ulong HTTP_QUERY_AUTHORIZATION                = 28
constant ulong HTTP_QUERY_CONTENT_ENCODING             = 29
constant ulong HTTP_QUERY_FORWARDED                    = 30
constant ulong HTTP_QUERY_FROM                         = 31
constant ulong HTTP_QUERY_IF_MODIFIED_SINCE            = 32
constant ulong HTTP_QUERY_LOCATION                     = 33
constant ulong HTTP_QUERY_ORIG_URI                     = 34
constant ulong HTTP_QUERY_REFERER                      = 35
constant ulong HTTP_QUERY_RETRY_AFTER                  = 36
constant ulong HTTP_QUERY_SERVER                       = 37
constant ulong HTTP_QUERY_TITLE                        = 38
constant ulong HTTP_QUERY_USER_AGENT                   = 39
constant ulong HTTP_QUERY_WWW_AUTHENTICATE             = 40
constant ulong HTTP_QUERY_PROXY_AUTHENTICATE           = 41
constant ulong HTTP_QUERY_ACCEPT_RANGES                = 42
constant ulong HTTP_QUERY_SET_COOKIE                   = 43
constant ulong HTTP_QUERY_COOKIE                       = 44
constant ulong HTTP_QUERY_REQUEST_METHOD               = 45  // special: GET/POST etc.
constant ulong HTTP_QUERY_REFRESH                      = 46
constant ulong HTTP_QUERY_CONTENT_DISPOSITION          = 47

//
// HTTP 1.1 defined headers
//

constant ulong HTTP_QUERY_AGE                          = 48
constant ulong HTTP_QUERY_CACHE_CONTROL                = 49
constant ulong HTTP_QUERY_CONTENT_BASE                 = 50
constant ulong HTTP_QUERY_CONTENT_LOCATION             = 51
constant ulong HTTP_QUERY_CONTENT_MD5                  = 52
constant ulong HTTP_QUERY_CONTENT_RANGE                = 53
constant ulong HTTP_QUERY_ETAG                         = 54
constant ulong HTTP_QUERY_HOST                         = 55
constant ulong HTTP_QUERY_IF_MATCH                     = 56
constant ulong HTTP_QUERY_IF_NONE_MATCH                = 57
constant ulong HTTP_QUERY_IF_RANGE                     = 58
constant ulong HTTP_QUERY_IF_UNMODIFIED_SINCE          = 59
constant ulong HTTP_QUERY_MAX_FORWARDS                 = 60
constant ulong HTTP_QUERY_PROXY_AUTHORIZATION          = 61
constant ulong HTTP_QUERY_RANGE                        = 62
constant ulong HTTP_QUERY_TRANSFER_ENCODING            = 63
constant ulong HTTP_QUERY_UPGRADE                      = 64
constant ulong HTTP_QUERY_VARY                         = 65
constant ulong HTTP_QUERY_VIA                          = 66
constant ulong HTTP_QUERY_WARNING                      = 67
constant ulong HTTP_QUERY_EXPECT                       = 68
constant ulong HTTP_QUERY_PROXY_CONNECTION             = 69
constant ulong HTTP_QUERY_UNLESS_MODIFIED_SINCE        = 70
constant ulong HTTP_QUERY_ECHO_REQUEST                 = 71
constant ulong HTTP_QUERY_ECHO_REPLY                   = 72

// These are the set of headers that should be added back to a request when
// re-doing a request after a RETRY_WITH response.
constant ulong HTTP_QUERY_ECHO_HEADERS                 = 73
constant ulong HTTP_QUERY_ECHO_HEADERS_CRLF            = 74

constant ulong HTTP_QUERY_MAX                          = 74

//
// HTTP_QUERY_CUSTOM - if this special value is supplied as the dwInfoLevel
// parameter of HttpQueryInfo() then the lpBuffer parameter contains the name
// of the header we are to query
//

constant ulong HTTP_QUERY_CUSTOM                       = 65535

//
// HTTP_QUERY_FLAG_REQUEST_HEADERS - if this bit is set in the dwInfoLevel
// parameter of HttpQueryInfo() then the request headers will be queried for the
// request information
//

constant ulong HTTP_QUERY_FLAG_REQUEST_HEADERS         = 2147483648 //0x80000000

//
// HTTP_QUERY_FLAG_SYSTEMTIME - if this bit is set in the dwInfoLevel parameter
// of HttpQueryInfo() AND the header being queried contains date information,
// e.g. the "Expires:" header then lpBuffer will contain a SYSTEMTIME structure
// containing the date and time information converted from the header string
//

constant ulong HTTP_QUERY_FLAG_SYSTEMTIME              = 1073741824 //0x40000000

//
// HTTP_QUERY_FLAG_NUMBER - if this bit is set in the dwInfoLevel parameter of
// HttpQueryInfo(), then the value of the header will be converted to a number
// before being returned to the caller, if applicable
//

constant ulong HTTP_QUERY_FLAG_NUMBER                  = 536870912 //0x20000000

//
// HTTP_QUERY_FLAG_COALESCE - combine the values from several headers of the
// same name into the output buffer
//

constant ulong HTTP_QUERY_FLAG_COALESCE                = 268435456 //0x10000000


constant ulong HTTP_QUERY_MODIFIER_FLAGS_MASK   = HTTP_QUERY_FLAG_REQUEST_HEADERS   &
                                                + HTTP_QUERY_FLAG_SYSTEMTIME        &
                                                + HTTP_QUERY_FLAG_NUMBER            &
                                                + HTTP_QUERY_FLAG_COALESCE          
                                                

//constant ulong HTTP_QUERY_HEADER_MASK           = not HTTP_QUERY_MODIFIER_FLAGS_MASK

//
// HTTP Response Status Codes:
//

constant ulong HTTP_STATUS_CONTINUE            = 100 // OK to continue with request
constant ulong HTTP_STATUS_SWITCH_PROTOCOLS    = 101 // server has switched protocols in upgrade header

constant ulong HTTP_STATUS_OK                  = 200 // request completed
constant ulong HTTP_STATUS_CREATED             = 201 // object created, reason = new URI
constant ulong HTTP_STATUS_ACCEPTED            = 202 // async completion (TBS)
constant ulong HTTP_STATUS_PARTIAL             = 203 // partial completion
constant ulong HTTP_STATUS_NO_CONTENT          = 204 // no info to return
constant ulong HTTP_STATUS_RESET_CONTENT       = 205 // request completed, but clear form
constant ulong HTTP_STATUS_PARTIAL_CONTENT     = 206 // partial GET furfilled

constant ulong HTTP_STATUS_AMBIGUOUS           = 300 // server couldn't decide what to return
constant ulong HTTP_STATUS_MOVED               = 301 // object permanently moved
constant ulong HTTP_STATUS_REDIRECT            = 302 // object temporarily moved
constant ulong HTTP_STATUS_REDIRECT_METHOD     = 303 // redirection w/ new access method
constant ulong HTTP_STATUS_NOT_MODIFIED        = 304 // if-modified-since was not modified
constant ulong HTTP_STATUS_USE_PROXY           = 305 // redirection to proxy, location header specifies proxy to use
constant ulong HTTP_STATUS_REDIRECT_KEEP_VERB  = 307 // HTTP/1.1: keep same verb

constant ulong HTTP_STATUS_BAD_REQUEST         = 400 // invalid syntax
constant ulong HTTP_STATUS_DENIED              = 401 // access denied
constant ulong HTTP_STATUS_PAYMENT_REQ         = 402 // payment required
constant ulong HTTP_STATUS_FORBIDDEN           = 403 // request forbidden
constant ulong HTTP_STATUS_NOT_FOUND           = 404 // object not found
constant ulong HTTP_STATUS_BAD_METHOD          = 405 // method is not allowed
constant ulong HTTP_STATUS_NONE_ACCEPTABLE     = 406 // no response acceptable to client found
constant ulong HTTP_STATUS_PROXY_AUTH_REQ      = 407 // proxy authentication required
constant ulong HTTP_STATUS_REQUEST_TIMEOUT     = 408 // server timed out waiting for request
constant ulong HTTP_STATUS_CONFLICT            = 409 // user should resubmit with more info
constant ulong HTTP_STATUS_GONE                = 410 // the resource is no longer available
constant ulong HTTP_STATUS_LENGTH_REQUIRED     = 411 // the server refused to accept request w/o a length
constant ulong HTTP_STATUS_PRECOND_FAILED      = 412 // precondition given in request failed
constant ulong HTTP_STATUS_REQUEST_TOO_LARGE   = 413 // request entity was too large
constant ulong HTTP_STATUS_URI_TOO_LONG        = 414 // request URI too long
constant ulong HTTP_STATUS_UNSUPPORTED_MEDIA   = 415 // unsupported media type
constant ulong HTTP_STATUS_RETRY_WITH          = 449 // retry after doing the appropriate action.

constant ulong HTTP_STATUS_SERVER_ERROR        = 500 // internal server error
constant ulong HTTP_STATUS_NOT_SUPPORTED       = 501 // required not supported
constant ulong HTTP_STATUS_BAD_GATEWAY         = 502 // error response received from gateway
constant ulong HTTP_STATUS_SERVICE_UNAVAIL     = 503 // temporarily overloaded
constant ulong HTTP_STATUS_GATEWAY_TIMEOUT     = 504 // timed out waiting for gateway
constant ulong HTTP_STATUS_VERSION_NOT_SUP     = 505 // HTTP version not supported

constant ulong HTTP_STATUS_FIRST               = HTTP_STATUS_CONTINUE
constant ulong HTTP_STATUS_LAST                = HTTP_STATUS_VERSION_NOT_SUP

end variables

on n_cst_wininet.create
TriggerEvent( this, "constructor" )
end on

on n_cst_wininet.destroy
TriggerEvent( this, "destructor" )
end on

