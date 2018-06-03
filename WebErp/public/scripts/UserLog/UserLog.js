function SaveEnterPageLog(rooturl, user, programno) {
    //Version = "v18.01.06";
    console.log('user3 = ' + user);
    if (user) {
        console.log('user2 = ' + user);
    } else {
        console.log('user1 = undefined ');
        user = 'davSaveEnterPageLog';
    }
    $.ajax({
        url: rootUrl + "Public/scripts/UserLog/EnterPageLog.ashx",
        async: true,
        cache: false,
        type: 'POST',
        dataTypes: "text",
        data: {
            user: user,
            programno: programno,
        },
        success: function (result) {

            console.log(result)

        }
    });

}