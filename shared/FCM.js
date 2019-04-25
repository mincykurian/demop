let FCM={
    android: {
        ttl: 3600 * 1000, // 1 hour in milliseconds
        priority: 'normal',
        data: {
            title: '',
            body: '',
            sound: 'default',
            image: 'www/assets/icon/logo.png',
            //style: 'picture',
            color: '#f45342',
            summaryText: '',
            target:'',
            payload:'',
            notId: (Math.floor(Math.random() * (99999999 - 1)) + 1).toString(),
            'content-available': '1',
            //picture: 'https://image.winudf.com/v2/image/Y29tLmFuZHJvbW8uZGV2MjY2Mjk5LmFwcDM2MDM5NV9zY3JlZW5zaG90c18xXzcyZGEyZDBm/screen-1.jpg?h=800&fakeurl=1&type=.jpg'
        }
    }
};
module.exports=FCM;