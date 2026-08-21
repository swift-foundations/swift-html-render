import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `Unicode Tests` {

    @Test
    func `ASCII text renders correctly`() throws {
        let html = tag("p") { HTML.Text("Hello, World!") }
        let rendered = try String(html)
        #expect(rendered == "<p>Hello, World!</p>")
    }

    @Test
    func `Latin extended characters`() throws {
        let html = tag("p") { HTML.Text("Héllo, Wörld! Señor, naïve, café") }
        let rendered = try String(html)
        #expect(rendered.contains("Héllo"))
        #expect(rendered.contains("Wörld"))
        #expect(rendered.contains("Señor"))
        #expect(rendered.contains("naïve"))
        #expect(rendered.contains("café"))
    }

    @Test
    func `German umlauts and eszett`() throws {
        let html = tag("p") { HTML.Text("Größe, Äpfel, Übung, öffentlich") }
        let rendered = try String(html)
        #expect(rendered.contains("Größe"))
        #expect(rendered.contains("Äpfel"))
        #expect(rendered.contains("Übung"))
    }

    @Test
    func `French accents`() throws {
        let html = tag("p") { HTML.Text("français, élève, où, ça, garçon") }
        let rendered = try String(html)
        #expect(rendered.contains("français"))
        #expect(rendered.contains("élève"))
    }

    @Test
    func `Japanese characters - Hiragana`() throws {
        let html = tag("p") { HTML.Text("こんにちは") }
        let rendered = try String(html)
        #expect(rendered.contains("こんにちは"))
    }

    @Test
    func `Japanese characters - Katakana`() throws {
        let html = tag("p") { HTML.Text("コンニチハ") }
        let rendered = try String(html)
        #expect(rendered.contains("コンニチハ"))
    }

    @Test
    func `Japanese characters - Kanji`() throws {
        let html = tag("p") { HTML.Text("日本語、漢字、東京") }
        let rendered = try String(html)
        #expect(rendered.contains("日本語"))
        #expect(rendered.contains("漢字"))
    }

    @Test
    func `Chinese characters - Simplified`() throws {
        let html = tag("p") { HTML.Text("你好世界，中文简体") }
        let rendered = try String(html)
        #expect(rendered.contains("你好世界"))
    }

    @Test
    func `Chinese characters - Traditional`() throws {
        let html = tag("p") { HTML.Text("繁體中文，臺灣") }
        let rendered = try String(html)
        #expect(rendered.contains("繁體中文"))
    }

    @Test
    func `Korean characters`() throws {
        let html = tag("p") { HTML.Text("안녕하세요, 한국어") }
        let rendered = try String(html)
        #expect(rendered.contains("안녕하세요"))
        #expect(rendered.contains("한국어"))
    }

    @Test
    func `Arabic text`() throws {
        let html = tag("p") { HTML.Text("مرحبا بالعالم") }
        let rendered = try String(html)
        #expect(rendered.contains("مرحبا"))
    }

    @Test
    func `Hebrew text`() throws {
        let html = tag("p") { HTML.Text("שלום עולם") }
        let rendered = try String(html)
        #expect(rendered.contains("שלום"))
    }

    @Test
    func `Thai text`() throws {
        let html = tag("p") { HTML.Text("สวัสดีครับ") }
        let rendered = try String(html)
        #expect(rendered.contains("สวัสดีครับ"))
    }

    @Test
    func `Hindi text (Devanagari)`() throws {
        let html = tag("p") { HTML.Text("नमस्ते दुनिया") }
        let rendered = try String(html)
        #expect(rendered.contains("नमस्ते"))
    }

    @Test
    func `Russian Cyrillic`() throws {
        let html = tag("p") { HTML.Text("Привет мир") }
        let rendered = try String(html)
        #expect(rendered.contains("Привет"))
    }

    @Test
    func `Greek text`() throws {
        let html = tag("p") { HTML.Text("Γειά σου Κόσμε") }
        let rendered = try String(html)
        #expect(rendered.contains("Γειά"))
    }

    @Test
    func `Basic emoji`() throws {
        let html = tag("p") { HTML.Text("Hello 👋 World 🌍") }
        let rendered = try String(html)
        #expect(rendered.contains("👋"))
        #expect(rendered.contains("🌍"))
    }

    @Test
    func `Complex emoji - skin tones`() throws {
        let html = tag("p") { HTML.Text("👋🏻 👋🏼 👋🏽 👋🏾 👋🏿") }
        let rendered = try String(html)
        #expect(rendered.contains("👋🏻"))
        #expect(rendered.contains("👋🏿"))
    }

    @Test
    func `Complex emoji - ZWJ sequences`() throws {
        let html = tag("p") { HTML.Text("👨‍👩‍👧‍👦 👩‍💻 🏳️‍🌈") }
        let rendered = try String(html)
        #expect(rendered.contains("👨‍👩‍👧‍👦"))
    }

    @Test
    func `Flag emoji`() throws {
        let html = tag("p") { HTML.Text("🇺🇸 🇬🇧 🇯🇵 🇩🇪 🇫🇷") }
        let rendered = try String(html)
        #expect(rendered.contains("🇺🇸"))
        #expect(rendered.contains("🇯🇵"))
    }

    @Test
    func `Mathematical symbols`() throws {
        let html = tag("p") { HTML.Text("∑ ∏ ∫ ∂ ∆ √ ∞ ≠ ≈ ≤ ≥") }
        let rendered = try String(html)
        #expect(rendered.contains("∑"))
        #expect(rendered.contains("∞"))
        #expect(rendered.contains("≠"))
    }

    @Test
    func `Currency symbols`() throws {
        let html = tag("p") { HTML.Text("$ € £ ¥ ₹ ₽ ฿ ₿") }
        let rendered = try String(html)
        #expect(rendered.contains("€"))
        #expect(rendered.contains("£"))
        #expect(rendered.contains("¥"))
    }

    @Test
    func `Arrows and symbols`() throws {
        let html = tag("p") { HTML.Text("← → ↑ ↓ ↔ ⇒ ⇐ • ° © ® ™") }
        let rendered = try String(html)
        #expect(rendered.contains("→"))
        #expect(rendered.contains("©"))
    }

    @Test
    func `Unicode in attribute values`() throws {
        let html = tag("div")
            .attribute("title", "日本語のタイトル")
            .attribute("data-greeting", "こんにちは")
        let rendered = try String(html)
        #expect(rendered.contains("日本語のタイトル"))
    }

    @Test
    func `Emoji in attribute values`() throws {
        let html = tag("button")
            .attribute("title", "Click me 🎉")
            .attribute("aria-label", "Celebrate 🎊")
        let rendered = try String(html)
        #expect(rendered.contains("🎉"))
    }

    @Test
    func `Mixed scripts in single text`() throws {
        let html = tag("p") {
            HTML.Text("Hello 你好 مرحبا Привет こんにちは")
        }
        let rendered = try String(html)
        #expect(rendered.contains("Hello"))
        #expect(rendered.contains("你好"))
        #expect(rendered.contains("مرحبا"))
        #expect(rendered.contains("Привет"))
        #expect(rendered.contains("こんにちは"))
    }

    @Test
    func `Multiple elements with different scripts`() throws {
        let html = tag("div") {
            tag("p") { HTML.Text("English") }.attribute("lang", "en")
            tag("p") { HTML.Text("日本語") }.attribute("lang", "ja")
            tag("p") { HTML.Text("العربية") }.attribute("lang", "ar")
        }
        let rendered = try String(html)
        #expect(rendered.contains("English"))
        #expect(rendered.contains("日本語"))
        #expect(rendered.contains("العربية"))
    }

    @Test
    func `Combining characters`() throws {

        let html = tag("p") { HTML.Text("cafe\u{0301}") }
        let rendered = try String(html)
        #expect(rendered.contains("é") || rendered.contains("e\u{0301}"))
    }

    @Test
    func `Zero-width characters`() throws {
        let html = tag("p") { HTML.Text("zero\u{200B}width\u{200B}space") }
        let rendered = try String(html)

        #expect(rendered.contains("\u{200B}"))
    }

    @Test
    func `Right-to-left override`() throws {
        let html = tag("p") { HTML.Text("Hello \u{202E}dlroW") }
        let rendered = try String(html)
        #expect(rendered.contains("\u{202E}"))
    }

    @Test
    func `Byte order mark (BOM)`() throws {
        let html = tag("p") { HTML.Text("\u{FEFF}Content with BOM") }
        let rendered = try String(html)

        #expect(rendered.contains("Content with BOM"))
    }

    @Test
    func `NFC normalized content`() throws {

        let html = tag("p") { HTML.Text("é") }
        let rendered = try String(html)
        #expect(rendered.contains("é"))
    }

    @Test
    func `NFD normalized content`() throws {

        let html = tag("p") { HTML.Text("e\u{0301}") }
        let rendered = try String(html)
        #expect(!rendered.isEmpty)
    }

    @Test
    func `Large multilingual content`() throws {
        var content = ""
        for _ in 0..<100 {
            content += "Hello 你好 مرحبا Привет こんにちは 안녕하세요 "
        }
        let html = tag("div") { HTML.Text(content) }
        let rendered = try String(html)
        #expect(rendered.contains("你好"))
        #expect(rendered.contains("こんにちは"))
    }
}

extension `Snapshot Tests` {
    @Suite
    struct `Unicode Snapshot Tests` {
        @Test
        func `Multilingual page snapshot`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("article") {
                        tag("h1") { HTML.Text("Welcome 欢迎 مرحبا") }
                        tag("p") { HTML.Text("This is English.") }
                        tag("p") { HTML.Text("これは日本語です。") }
                        tag("p") { HTML.Text("هذه اللغة العربية.") }
                    }
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                  </head>
                  <body>
                    <article>
                      <h1>Welcome 欢迎 مرحبا
                      </h1>
                      <p>This is English.
                      </p>
                      <p>これは日本語です。
                      </p>
                      <p>هذه اللغة العربية.
                      </p>
                    </article>
                  </body>
                </html>
                """
            }
        }
    }
}
