#!/bin/bash
#sid="00DU0000000GzlP!AQ0AQM.YERGbkvk6gGUbnIh8MYjj29hxsFOASTOCHnvTyoLc2JztXIMn_HCiCe2ugZJHXMz7XJfPwE08aIGz6VTnrajOtrqZ"
sid="00D80000000ajhG!AQcAQNuDERL83tHNFO6T5vMmoEgulscw7DHUA4TjfI7eLPq8p2hQm14K9Z27HTTOoKCIK4LpC1wVtUdDWTEoFV8cJ0SrRzJO"
#othersid="00DU0000000GzlP!AQ0AQNzgQahG5.wnL8OKMfT.hnDzduGLUPjkX6hXXvDlouGgtNckhcTpFmr7SdvpripuHiaSyCA2n0ufMQpgRlU_OewRtSa0"
#url="https://na12.salesforce.com/cometd"
url="https://na6.salesforce.com/cometd"
pushtopicurl="https://na6.salesforce.com/services/data/v22.0/sobjects/PushTopic"
testobjecturl="https://na6.salesforce.com/services/data/v22.0/sobjects/TestObject__c"
#sid2="00DU0000000GzlP!AQ0AQKsUhfFFudUci3kWkBOSnMpd1LVz2y4h3Zv1IX0oXJ1mun9AQUMnzFQFnGwmKv5aVLidi54_p5vKv_f_9d1wG.1CzTlw"

#Make a push topic
#curl -v -X POST $pushtopicurl -H "Authorization: OAuth $sid" -H "Content-Type:application/json" -H "X-PrettyPrint:1" -d '{"Name":"TestTopic2", "query":"Select id, name, status__c from TestObject__c", "ApiVersion":22.0}'

#Check it
#curl -v -X GET "$pushtopicurl/0IFU00000004C9SOAU" -H "Content-Type:application/json" -H "X-PrettyPrint:1" -H "Authorization: OAuth $othersid" 

#Handshake
#curl -v -X POST -c setcookie.txt $url -H "Cookie: sid=$sid" -H "X-PrettyPrint:1" -H "Content-Type:application/json" -H "Host:na6.salesforce.com" -d  '[{"channel":"/meta/handshake","version":"1.0","supportedConnectionTypes":["long-polling"]}]'

#Set-Cookie: inst=APPU; domain=.salesforce.com; path=/

#Reconnect
curl -v -X POST -b mycookies.txt $url -g -H "X-PrettyPrint:1" -H "Content-Type:application/json" -H "Host:na6.salesforce.com" -H -d'{"channel":"/meta/connect","clientId":"216g6kpfybqkgn142rygsg28nj6","connectionType":"long-polling","id":"3","ext":{"auth":"00D80000000ajhG!AQcAQNuDERL83tHNFO6T5vMmoEgulscw7DHUA4TjfI7eLPq8p2hQm14K9Z27HTTOoKCIK4LpC1wVtUdDWTEoFV8cJ0SrRzJO","login":"aashayd@gmail.com"}}'


#Subscribe
#curl -v -X POST -b mycookies.txt $url -g -H "X-PrettyPrint:1" -H "Content-Type:application/json" -H "Host:na6.salesforce.com" -H -d '[{"channel":"/meta/subscribe","clientId":"216g6kpfybqkgn142rygsg28nj6","subscription":"TestTopic","id":"2","ext":{"auth":"00D80000000ajhG!AQcAQNuDERL83tHNFO6T5vMmoEgulscw7DHUA4TjfI7eLPq8p2hQm14K9Z27HTTOoKCIK4LpC1wVtUdDWTEoFV8cJ0SrRzJO"}}]'



#Make the actual object
#curl -v -X POST $testobjecturl -H "Authorization: OAuth $sid" -H "X-PrettyPrint:1" -d '[{"Name":"Enna", "Status__c":"Muthum"}]'