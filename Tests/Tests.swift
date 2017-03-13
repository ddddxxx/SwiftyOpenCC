//
//  Tests.swift
//  Tests
//
//  Created by 邓翔 on 2017/3/9.
//
//

import XCTest
@testable import OpenCC

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConversion() {
        let s2d = ChineseConverter(option: [.traditionalize])
        let d2s = ChineseConverter(option: [.simplify])
        
        let str = "忧郁的台湾乌龟"
        let str1 = s2d.convert(str)
        let str2 = d2s.convert(str1)
        XCTAssertTrue(str == str2)
    }
    
    func testConverterCreation() {
        let options: [ChineseConverter.Options] = [.traditionalize, .simplify, .TWStandard, .HKStandard, .TWIdiom, .textDict]
        for combination in options.combinational {
            let option = ChineseConverter.Options(combination)
            _ = ChineseConverter(option: option)
        }
    }
    
    func testConverterCreationPerformance() {
        self.measure {
            _ = ChineseConverter(option: [.traditionalize, .TWStandard, .TWIdiom])
        }
    }
    
    func testConversionPerformance() {
        let testConverter = ChineseConverter(option: [.traditionalize, .TWStandard, .TWIdiom])
        self.measure {
            _ = testConverter.convert(self.testText)
        }
    }
    
    func testTextDictionaryCreationPerformance() {
        self.measure {
            _ = ChineseConverter(option: [.traditionalize, .TWStandard, .TWIdiom, .textDict])
        }
    }
    
    func testTextDictionaryPerformance() {
        let testConverter = ChineseConverter(option: [.traditionalize, .TWStandard, .TWIdiom, .textDict])
        self.measure {
            _ = testConverter.convert(self.testText)
        }
    }
    
    // 2840 characters
    let testText = "Apple Inc. iOS软件许可协议 单一使用许可证 请先仔细阅读本软件许可协议(“许可证”),然后才使用阁下的iOS装置或下载附随本许可证的软件更新。阁 下一使用iOS装置或下载软件更新(视适用而定),即表示同意接受本许可证的条款约 束。如阁下不同意本许 可证的条款,请勿使用iOS装置或下载该软件更新。 如阁下最近购买iOS装置并且如阁下不同意许可证条款,可将iOS装置交还购取iOS装置的APPLE专 卖店或授 权分销商以取得退款,但须符合APPLE的退货政策规定,该政策载于http://www.apple.com/legal/ sales_policies/。 1. 一般规定。 (a) 连同阁下的iOS装置提供并可以Apple提供的功能增强软件、软件更新或系统恢复软件( “iOS软件更 新”)予以更新或取代的软件(包括Boot ROM代码、嵌入式软件和第三方软件)、文档、界 面、内容、字体 及任何数据( “原iOS软件”),不论是储存于只读存储器、任何其它载体或属任何其它形式(原iOS软件和iOS 软件更新统称“iOS软件”),是由Apple Inc.(“Apple”)许可阁 下使用而非售予阁下。阁下只可根据本许 可证的条款加以使用,Apple及其许可人保留对iOS软件本身的所有权,并保留一切并未明确授予阁下的权 利。阁下同意本许可证条款将适用于任何可能已预安装在阁下的iOS装置上的Apple品牌app，除非该app 另外附有单独的许可证，在这种情况下，阁下同意该许可证的条款将规限阁下对该app的使用。 (b) Apple可就阁下的iOS裝置酌情提供未来的iOS软件更新,这些更新(如有的话)未必包含Apple就较新或其 他型号iOS裝置发行的所有现有软件功能或新的功能。本许可证条款监管由Apple提供用以取代和/或补充 原先iOS软件产品的iOS软件更新，除非该iOS软件更新另外载有独立许可证，在此情况下则以该许可证的条 款监管。 2. 允许的许可证用途和限制。 (a) 在必须遵守本许可证条款和条件的情况下,阁下获授予在单一台Apple品牌iOS装置上使用iOS软件的有 限的、非独家的许可证。除以下第2(b) 条允许外, 以及除非阁下与Apple另行签立协议规定外，本许可证不 允许iOS软件 在任何一个时候存在于一台以上Apple品牌iOS装置上,而且阁下不得在网络上分发或提供iOS 软件,以致iOS软件在同一时间可供多台装置使用。本许可证并不授予阁下 使用Apple拥有专有权的界面及 其它知识产权,以设计、开发、制造、授予许可或分发第三方装置与配件或第三方应用软件连同iOS装置使 用的任何权利。在获得Apple的另行许可下，可使用其中某些权利。有关为iOS装置开发第三方装置与配件 的详情，请发电子邮件至 madeforipod@apple.com。有关为iOS装置开发应用软件的详情，请发电子邮 件至 devprograms@apple.com。 (b) 在必须遵守本许可证条款和条件的情况下,阁下获授予下载Apple可能提供给阁下iOS装置型号的iOS软 件更新的有限的、非独家许可证,以更新或恢复由阁下拥有或控制的任何此类iOS装置 上的软件。本许可证 并不允许阁下更新或恢复不受阁下控制的或并非阁下拥有的iOS装置,而且阁下不得在网络上分发或提供iOS 软件,以致iOS软件在同一时间可供多台装置或多台计算机使 用。如阁下下载iOS软件更新到阁下的计算机 上，阁下只可为备份目的而以机器可读形式,复制一份存储於阁下的计算机的iOS软件更新;但该备份副本必 须带有原件上所载的一切著作权或其它专有权的提示。 (c) 在阁下购买时Apple已在阁下的iOS装置上预安装Apple品牌app (“预安装app”)的范围内，阁下需 要登录到App Store并将这些预安装app关联到阁下的App Store帐户，才能在阁下的iOS装置上使用它 们。当阁下将预安装app关联到阁下的App Store帐户时，阁下的iOS装置上所有其他预安装app将会同时 自动关联起来。阁下选择将预安装app与阁下的App Store账户关联，即表示阁下同意 Apple可传输、收 集、维护、处理和使用阁下的App Store账户所使用的Apple ID和收集自阁下的iOS装置的唯一硬件标识 符，作为验证阁下所提出请求的资格的唯一账户标识符，以及向阁下提供通过App Store存取预安装app 的途径。如阁下不希望使用预安装app，阁下可随时将其从阁下的iOS装置中删除。 (d) 阁下不得且阁下同意不会或促使他人复制(本许可证明示允许除外)、反汇编、倒序制造、拆装、企图导 出其源代码、解码、修改iOS软件或制造其衍生作品、或iOS软件提供的任何服务 或其任何部分(适用法律 或可能包含在iOS软件内的开放源代码组件使用许可证条款禁止除外)。 (e) iOS软件可用于复制材料,只要该等使用限于复制没有版权的材料、阁 下享有著作权的材料或授权阁下或 合法允许阁下复制的材料。通过阁下的iOS装置显示、存储或访问的任何内容，其所有权和知识产权属于相 关的内容所有权人。此等内容可能受著作权或其他知识产权法律和条约保护，及可能须遵守提供该等内容 的第三方使用条款。除在此另有规定外，本许可证并不授予阁下使用该等内容的任何权利，亦不保证该等 内容将继续提供给阁下。 (f) 阁下同意依照所有适用法律使用iOS软件以及服务(定义见以下第5条),此等法律包括阁下所居住或者下载 或使用iOS软件以及服务的国家或地区的当地法律。iOS软件和服务的功能未必以所有语言或在所有地区提 供，某些功能可能因地区而异，有的可能会受到限制，或阁下的服务提供商没有提供。iOS软件和服务一些 功能需要Wi-Fi或蜂窝数据连接，例如FaceTime或iMessage。 (g) 使用App Store需要一个名为Apple ID的独有用户名称和密码组合。要存取app的更新版本及iOS软件 和服务的某些功能，同样需要一个Apple ID。此外，阁下承认iOS软件许多功能和服务会传输数据，可能影 响阁下数据计划的收费，以及阁下须负责该等收费。阁下可在Cellular Data Settings项下控制哪些应用程 序获准使用蜂窝数据，并查看该等应用程序已消耗了多少数据的估计。欲了解更多信息，请查阅阁下iOS装 置的用户指南。 (h) 如阁下选择允许自动更新app，阁下的iOS装置会向Apple定期查询有关更新阁下装置上的app的问 题。如有提供的话，更新版本会自动下载和安装到阁下的装置上。阁下可随时完全关闭app的自动更新， 只需前往Settings，点选iTunes & App Store，然后在Automatic Downloads项下关闭Updates。"
    
}

extension Array {
    
    var combinational: [[Element]] {
        return reduce([[Element]]()) { (result: [[Element]], element: Element) in
            return result + [[element]] + result.map() { (array: [Element]) -> [Element] in
                return array + [element]
            }
        }
    }
    
}
