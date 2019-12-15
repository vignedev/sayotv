const http = require('http'), fs = require('fs')

const cachedFiles = [
    'assets/2kTest_flip.png',
    'assets/2kTest_rotate.png',
    'assets/2kTest.png'
].map(x => fs.readFileSync(x))

const slides = [
    {
        images: ['/images/test_1.png'],
        timeout:null
    },
    {
        images: ['http://flutter.g6.cz/cross.php?url=https://safebooru.org//images/2731/ad9ccd44bbef27851f70688d1375cb65c07e90ec.png'],
        timeout: 60*50
    },
    {
        images: [
            '/images/test_1.png',
            '/images/test_2.png',
            '...'
        ],
        timeout: null
    },
    {
        images: [
            '/images/test_3.png',
            '/images/test_4.png'
        ],
        timeout: null
    }
]

const server = http.createServer((req,res) => {
    switch(req.url){
        case '/api/info':
            res.end(JSON.stringify(
                {
                    slides,//: (Math.random() > 0.5) ? [] : slides,
                    marquee: '美しき命の艶麗 紡がれた調べ 生まれゆく道 Believe me this is the right way 灯りは何処へ消えた? 手繰り寄せるように 伸ばす手は何も掴めないまま 息継ぎも上手くできず 冷えた唇 黙り込む'
                }
            ))
            break
        case '/images/test_1.png':
        case '/images/test_2.png':
            res.end(cachedFiles[0]) 
            break
        case '/images/test_3.png':
        case '/images/test_4.png':
            res.end(cachedFiles[1])
            break
        default:
            res.statusCode = 400
            res.end()
            break
    }
})
server.listen(89) //Math.floor(Math.random() * cachedFiles.length)