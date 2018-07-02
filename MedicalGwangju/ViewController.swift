import UIKit

class ViewController: UIViewController, XMLParserDelegate{

    var datalist = [[String:String]]()
    var detaildata = [String:String]()
    var parseTemp:String = ""
    var blank:Bool=true
    @IBOutlet var waittingBar: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = "&Q0=광주광역시&Q1=북구"
        
        let encoded = request.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let urlString = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncListInfoInqire?serviceKey=tLUTwV4lVmKDLfCqjBGPA6ZrX607dgZWKXQFA2u7qOTtxFTDyIw0gd8BwzofN5MZRerdFqLZ2AomUhYTukjs4A%3D%3D"+encoded
        
        print(urlString)
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let baseURL = URL(string: urlString) else{
            //통신할때 사용 무조건 else문 필요
            print("URL error")
            return
        }
        
        guard let parser = XMLParser(contentsOf: baseURL) else{
            print("Can't read data")
            return
        }
        
        parser.delegate = self //자신을 델리게이트에 연결
        
        self.waittingBar.startAnimating()
        
        let success:Bool = parser.parse()
        
        if success {
            print("파싱 성공")
            var dicTemp = datalist[0]
            print("값: \(dicTemp["dutyAddr"])")
        }
        else{
            print("파싱 실패")
        }
        
        self.waittingBar.stopAnimating()
    }
    
    //element시작 잡는다 (element는 xml데이터)
    //<country>    한국        </country>
    // 시작.    중간(string)       끝(EndElement)에서 잡힌다.
    //시작태그를 만나면 호출
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        parseTemp = elementName
        blank = true //블랭크를 쓰는 이유는 xml에서 <ㅁ><ㅁ/>뒤에 \n까지 캐릭터로 잡아버려서 detaildata의 ㅁ키 값을 \n으로 바꾸게 된다. 이를 잡아주기 위해
        
    }
    
    //중간의 아이템 값을 만나면 호출
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //딕셔너리에 스트링값 깔끔히 trim해서 넣어주기
        if blank == true {
            detaildata[parseTemp] = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
        }
    }
    
    //끝 태그를 만나면 호출
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item"{
            datalist.append(detaildata)
        }
        blank = false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

