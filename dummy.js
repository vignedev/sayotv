const http = require('http'), fs = require('fs')

const cachedFiles = [
    'assets/2kTest_flip.png',
    'assets/2kTest_rotate.png',
    'assets/2kTest.png'
].map(x => fs.readFileSync(x))

const server = http.createServer((req,res) => {
    switch(req.url){
        case '/api/info':
            res.end(JSON.stringify(
                {
                    slides: [
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
                    ],
                    marquee: '美しき命の艶麗 紡がれた調べ 生まれゆく道 Believe me this is the right way 灯りは何処へ消えた? 手繰り寄せるように 伸ばす手は何も掴めないまま 息継ぎも上手くできず 冷えた唇 黙り込む'
                }
            ))
            break
        case '/images/test_1.png':
        case '/images/test_2.png':
        case '/images/test_3.png':
        case '/images/test_4.png':
            res.end(cachedFiles[Math.floor(Math.random() * cachedFiles.length)])
            break
        default:
            res.statusCode = 400
            res.end()
            break
    }
})
server.listen(89)