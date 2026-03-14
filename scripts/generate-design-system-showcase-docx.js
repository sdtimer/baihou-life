const fs = require("fs");
const path = require("path");
const {
  AlignmentType,
  BorderStyle,
  Document,
  ExternalHyperlink,
  Footer,
  Header,
  HeadingLevel,
  PageNumber,
  Packer,
  Paragraph,
  ShadingType,
  Table,
  TableCell,
  TableRow,
  TextRun,
  WidthType,
} = require("docx");

const outputDir = path.join(__dirname, "..", "docs", "outputs");
const outputPath = path.join(outputDir, "柏厚生活设计系统展示版_2026-03-10.docx");

const colors = {
  brandPrimary: "6F5A45",
  brandPrimaryHover: "5F4C3A",
  brandPrimarySoft: "F3EEE8",
  brandAccent: "7D8A63",
  brandAccentSoft: "EEF1E8",
  bgBase: "F7F4EF",
  surface: "FFFFFF",
  surfaceMuted: "F2EEE8",
  textPrimary: "2F2A26",
  textSecondary: "6C655E",
  textTertiary: "9B938B",
  border: "DDD5CC",
  borderStrong: "BDAF9F",
  success: "3E7B57",
  successSoft: "EAF5EE",
  warning: "B9852B",
  warningSoft: "FBF3E4",
  error: "B74D45",
  errorSoft: "F9ECEA",
  info: "4E6A7D",
  infoSoft: "EAF0F4",
  disabledBg: "ECE7E1",
  disabledText: "A59D95",
};

const borderAll = {
  top: { style: BorderStyle.SINGLE, size: 1, color: colors.border },
  bottom: { style: BorderStyle.SINGLE, size: 1, color: colors.border },
  left: { style: BorderStyle.SINGLE, size: 1, color: colors.border },
  right: { style: BorderStyle.SINGLE, size: 1, color: colors.border },
};

function text(text, options = {}) {
  return new TextRun({
    text,
    color: options.color || colors.textPrimary,
    bold: options.bold || false,
    italics: options.italics || false,
    size: options.size,
    break: options.break || 0,
  });
}

function p(children, options = {}) {
  return new Paragraph({
    children: Array.isArray(children) ? children : [children],
    heading: options.heading,
    alignment: options.alignment,
    pageBreakBefore: options.pageBreakBefore,
    spacing: options.spacing || { after: 140 },
    shading: options.shading,
    indent: options.indent,
    border: options.border,
  });
}

function bullet(items) {
  return items.map(
    (item) =>
      new Paragraph({
        text: item,
        numbering: { reference: "bullets", level: 0 },
        spacing: { after: 100 },
      }),
  );
}

function heroSvg() {
  return `
  <svg width="1200" height="540" viewBox="0 0 1200 540" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
        <stop offset="0%" stop-color="#F7F4EF"/>
        <stop offset="50%" stop-color="#F3EEE8"/>
        <stop offset="100%" stop-color="#EEF1E8"/>
      </linearGradient>
      <linearGradient id="line" x1="0" y1="0" x2="1" y2="0">
        <stop offset="0%" stop-color="#6F5A45"/>
        <stop offset="100%" stop-color="#7D8A63"/>
      </linearGradient>
    </defs>
    <rect width="1200" height="540" rx="36" fill="url(#bg)"/>
    <circle cx="1030" cy="106" r="120" fill="#E7DED3"/>
    <circle cx="1090" cy="412" r="154" fill="#E7EBDD"/>
    <rect x="70" y="64" width="178" height="34" rx="17" fill="#6F5A45"/>
    <text x="102" y="86" fill="#FFFFFF" font-size="20" font-family="PingFang SC, Microsoft YaHei, sans-serif">Baihou Life</text>
    <text x="78" y="182" fill="#2F2A26" font-size="52" font-weight="700" font-family="PingFang SC, Microsoft YaHei, sans-serif">设计系统展示版</text>
    <text x="78" y="246" fill="#6C655E" font-size="26" font-family="PingFang SC, Microsoft YaHei, sans-serif">暖中性现代家居气质 / 小程序与后台双端统一基线</text>
    <text x="78" y="294" fill="#6C655E" font-size="26" font-family="PingFang SC, Microsoft YaHei, sans-serif">用于视觉提案、设计对齐与跨团队沟通</text>
    <rect x="78" y="340" width="420" height="2" fill="url(#line)"/>
    <text x="78" y="396" fill="#2F2A26" font-size="24" font-weight="600" font-family="PingFang SC, Microsoft YaHei, sans-serif">一套品牌基线，双端差异表达</text>
    <text x="78" y="432" fill="#6C655E" font-size="20" font-family="PingFang SC, Microsoft YaHei, sans-serif">基于《06-设计系统.md》整理重构，适合给美工和视觉团队快速看方向。</text>
    <rect x="758" y="96" width="288" height="124" rx="24" fill="#FFFFFF" stroke="#DDD5CC"/>
    <text x="792" y="144" fill="#7D8A63" font-size="22" font-weight="600" font-family="PingFang SC, Microsoft YaHei, sans-serif">空间感</text>
    <text x="792" y="178" fill="#6C655E" font-size="18" font-family="PingFang SC, Microsoft YaHei, sans-serif">留白、秩序、材质层次</text>
    <rect x="836" y="238" width="248" height="108" rx="24" fill="#6F5A45"/>
    <text x="870" y="286" fill="#FFFFFF" font-size="22" font-weight="600" font-family="PingFang SC, Microsoft YaHei, sans-serif">品牌统一</text>
    <text x="870" y="320" fill="#F3EEE8" font-size="18" font-family="PingFang SC, Microsoft YaHei, sans-serif">色彩、圆角、语义一致</text>
    <rect x="726" y="372" width="258" height="98" rx="24" fill="#FFFFFF" stroke="#DDD5CC"/>
    <text x="760" y="420" fill="#2F2A26" font-size="22" font-weight="600" font-family="PingFang SC, Microsoft YaHei, sans-serif">高效落地</text>
    <text x="760" y="452" fill="#6C655E" font-size="18" font-family="PingFang SC, Microsoft YaHei, sans-serif">组件与 token 直接进入研发</text>
  </svg>`;
}

function calloutCell(title, body, fill) {
  return new TableCell({
    width: { size: 3000, type: WidthType.DXA },
    borders: borderAll,
    shading: { fill, type: ShadingType.CLEAR },
    margins: { top: 160, bottom: 160, left: 180, right: 180 },
    children: [
      p(text(title, { bold: true, size: 24, color: colors.textPrimary }), {
        spacing: { after: 100 },
      }),
      p(text(body, { size: 20, color: colors.textSecondary }), {
        spacing: { after: 0 },
      }),
    ],
  });
}

function blockCell(title, body, fill, titleColor = colors.textPrimary, bodyColor = colors.textSecondary) {
  return new TableCell({
    borders: borderAll,
    shading: { fill, type: ShadingType.CLEAR },
    margins: { top: 180, bottom: 180, left: 180, right: 180 },
    children: [
      p(text(title, { bold: true, size: 24, color: titleColor }), { spacing: { after: 90 } }),
      p(text(body, { size: 18, color: bodyColor }), { spacing: { after: 0 } }),
    ],
  });
}

function heroBoardTable() {
  return new Table({
    width: { size: 9360, type: WidthType.DXA },
    columnWidths: [4300, 2500, 2560],
    rows: [
      new TableRow({
        children: [
          new TableCell({
            width: { size: 4300, type: WidthType.DXA },
            borders: borderAll,
            shading: { fill: colors.brandPrimarySoft, type: ShadingType.CLEAR },
            margins: { top: 260, bottom: 260, left: 220, right: 220 },
            children: [
              p(text("一套品牌基线", { size: 34, bold: true }), { spacing: { after: 110 } }),
              p(text("双端差异表达", { size: 30, bold: true, color: colors.brandAccent }), {
                spacing: { after: 140 },
              }),
              p(
                text(
                  "把小程序的空间感与后台的效率感放在同一气质体系里，既保留品牌统一，又避免前后台像两个项目。",
                  { size: 21, color: colors.textSecondary },
                ),
                { spacing: { after: 0 } },
              ),
            ],
          }),
          blockCell("空间感", "留白、秩序、材质层次", "FFFFFF", colors.brandAccent),
          blockCell("高效落地", "token 与组件可直接进研发", "EEF1E8", colors.textPrimary),
        ],
      }),
    ],
  });
}

function paletteBoardTable() {
  const rows = [
    [
      ["Brand Primary", "#6F5A45", colors.brandPrimary, "FFFFFF"],
      ["Brand Accent", "#7D8A63", colors.brandAccent, "FFFFFF"],
      ["Background Base", "#F7F4EF", colors.bgBase, colors.textPrimary],
      ["Text Primary", "#2F2A26", colors.textPrimary, "FFFFFF"],
    ],
    [
      ["Primary Soft", "#F3EEE8", colors.brandPrimarySoft, colors.textPrimary],
      ["Accent Soft", "#EEF1E8", colors.brandAccentSoft, colors.textPrimary],
      ["Surface Muted", "#F2EEE8", colors.surfaceMuted, colors.textPrimary],
      ["Border", "#DDD5CC", colors.border, colors.textPrimary],
    ],
    [
      ["Success", "#3E7B57", colors.success, "FFFFFF"],
      ["Warning", "#B9852B", colors.warning, "FFFFFF"],
      ["Error", "#B74D45", colors.error, "FFFFFF"],
      ["Info", "#4E6A7D", colors.info, "FFFFFF"],
    ],
  ];

  return new Table({
    width: { size: 9360, type: WidthType.DXA },
    columnWidths: [2340, 2340, 2340, 2340],
    rows: rows.map(
      (row) =>
        new TableRow({
          children: row.map(([title, hex, fill, textColor]) =>
            new TableCell({
              borders: borderAll,
              shading: { fill, type: ShadingType.CLEAR },
              margins: { top: 200, bottom: 200, left: 160, right: 160 },
              children: [
                p(text(title, { bold: true, size: 22, color: textColor }), {
                  spacing: { after: 80 },
                }),
                p(text(hex, { size: 18, color: textColor }), { spacing: { after: 0 } }),
              ],
            }),
          ),
        }),
    ),
  });
}

function rhythmBoardTable() {
  return new Table({
    width: { size: 9360, type: WidthType.DXA },
    columnWidths: [4680, 4680],
    rows: [
      new TableRow({
        children: [
          new TableCell({
            width: { size: 4680, type: WidthType.DXA },
            borders: borderAll,
            shading: { fill: "FAF8F4", type: ShadingType.CLEAR },
            margins: { top: 220, bottom: 220, left: 180, right: 180 },
            children: [
              p(text("字体层级示例", { bold: true, size: 24 }), { spacing: { after: 120 } }),
              p(text("Display 28 / 36", { bold: true, size: 34 }), { spacing: { after: 80 } }),
              p(text("H1 24 / 32", { bold: true, size: 30 }), { spacing: { after: 70 } }),
              p(text("H2 20 / 28", { bold: true, size: 26 }), { spacing: { after: 70 } }),
              p(text("Body 16 / 24", { size: 22 }), { spacing: { after: 60 } }),
              p(text("Caption 12 / 18", { size: 18, color: colors.textSecondary }), {
                spacing: { after: 0 },
              }),
            ],
          }),
          new TableCell({
            width: { size: 4680, type: WidthType.DXA },
            borders: borderAll,
            shading: { fill: "FFFFFF", type: ShadingType.CLEAR },
            margins: { top: 220, bottom: 220, left: 180, right: 180 },
            children: [
              p(text("空间与圆角建议", { bold: true, size: 24 }), { spacing: { after: 120 } }),
              p(text("间距 token：4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48 / 64", { size: 20 }), {
                spacing: { after: 100 },
              }),
              p(text("圆角：6 / 8 / 12 / 16 / 20 / Pill", { size: 20 }), { spacing: { after: 100 } }),
              p(text("输入框与小按钮用 8px；卡片与筛选区用 12px；Banner 与大图模块用 16px。", {
                size: 18,
                color: colors.textSecondary,
              }), {
                spacing: { after: 0 },
              }),
            ],
          }),
        ],
      }),
    ],
  });
}

function componentBoardTable() {
  return new Table({
    width: { size: 9360, type: WidthType.DXA },
    columnWidths: [2340, 2340, 2340, 2340],
    rows: [
      new TableRow({
        children: [
          blockCell("Primary", "主操作按钮", colors.brandPrimary, "FFFFFF", "FFFFFF"),
          blockCell("Ghost", "弱边框操作", "FFFFFF", colors.brandPrimary),
          blockCell("Secondary", "辅助行动", colors.brandAccentSoft, colors.brandAccent),
          blockCell("Danger", "删除与风险操作", colors.errorSoft, colors.error),
        ],
      }),
      new TableRow({
        children: [
          blockCell("草稿", "中性灰", colors.disabledBg, colors.textSecondary),
          blockCell("已上架 / 成功", "绿色标签", colors.successSoft, colors.success),
          blockCell("待处理", "黄色标签", colors.warningSoft, colors.warning),
          blockCell("异常", "红色标签", colors.errorSoft, colors.error),
        ],
      }),
    ],
  });
}

function infoTable(rows, widths) {
  return new Table({
    width: { size: 9360, type: WidthType.DXA },
    columnWidths: widths,
    rows: rows.map(
      (row, rowIndex) =>
        new TableRow({
          children: row.map((cell, index) => {
            const width = widths[index];
            return new TableCell({
              width: { size: width, type: WidthType.DXA },
              borders: borderAll,
              shading: {
                fill: rowIndex === 0 ? colors.brandPrimarySoft : "FFFFFF",
                type: ShadingType.CLEAR,
              },
              margins: { top: 110, bottom: 110, left: 140, right: 140 },
              children: [
                p(
                  text(cell, {
                    bold: rowIndex === 0,
                    size: 20,
                    color: rowIndex === 0 ? colors.textPrimary : colors.textSecondary,
                  }),
                  { spacing: { after: 0 } },
                ),
              ],
            });
          }),
        }),
    ),
  });
}

const doc = new Document({
  styles: {
    default: {
      document: {
        run: {
          font: "PingFang SC",
          size: 21,
          color: colors.textPrimary,
        },
        paragraph: {
          spacing: { line: 360, after: 100 },
        },
      },
    },
    paragraphStyles: [
      {
        id: "Heading1",
        name: "Heading 1",
        basedOn: "Normal",
        next: "Normal",
        quickFormat: true,
        run: { font: "PingFang SC", size: 32, bold: true, color: colors.textPrimary },
        paragraph: { spacing: { before: 280, after: 180 }, outlineLevel: 0 },
      },
      {
        id: "Heading2",
        name: "Heading 2",
        basedOn: "Normal",
        next: "Normal",
        quickFormat: true,
        run: { font: "PingFang SC", size: 26, bold: true, color: colors.textPrimary },
        paragraph: { spacing: { before: 220, after: 140 }, outlineLevel: 1 },
      },
    ],
  },
  numbering: {
    config: [
      {
        reference: "bullets",
        levels: [
          {
            level: 0,
            format: "bullet",
            text: "•",
            alignment: AlignmentType.LEFT,
            style: { paragraph: { indent: { left: 480, hanging: 240 } } },
          },
        ],
      },
    ],
  },
  sections: [
    {
      properties: {
        page: {
          size: { width: 11906, height: 16838 },
          margin: { top: 1080, right: 1080, bottom: 1080, left: 1080 },
        },
      },
      headers: {
        default: new Header({
          children: [
            new Paragraph({
              alignment: AlignmentType.RIGHT,
              children: [text("Baihou Life Design System Showcase", { size: 16, color: colors.textTertiary })],
            }),
          ],
        }),
      },
      footers: {
        default: new Footer({
          children: [
            new Paragraph({
              alignment: AlignmentType.CENTER,
              children: [
                text("柏厚生活设计系统展示版  |  "),
                text("Page ", { color: colors.textTertiary }),
                new TextRun({ children: [PageNumber.CURRENT] }),
              ],
            }),
          ],
        }),
      },
      children: [
        p(text("柏厚生活", { size: 20, color: colors.brandAccent, bold: true }), {
          spacing: { after: 120 },
        }),
        p(text("设计系统展示版", { size: 40, bold: true }), {
          spacing: { after: 100 },
        }),
        p(text("给美工与视觉团队的沟通稿", { size: 24, color: colors.textSecondary }), {
          spacing: { after: 280 },
        }),
        heroBoardTable(),
        p(
          [
            text("基于执行版规范《06-设计系统.md》重构，本稿更强调 "),
            text("品牌感、界面氛围、组件语气", { bold: true }),
            text(" 与 "),
            text("双端视觉差异", { bold: true }),
            text("，适合在设计评审和视觉对齐场景中快速达成共识。"),
          ],
          { spacing: { after: 160 } },
        ),
        new Table({
          width: { size: 9360, type: WidthType.DXA },
          columnWidths: [3120, 3120, 3120],
          rows: [
            new TableRow({
              children: [
                calloutCell("品牌氛围", "暖中性现代家居，不做电商促销感，也不做冷奢黑金。", "F8F3ED"),
                calloutCell("设计策略", "一套品牌基线，两种终端表达。小程序更有场景感，后台更讲效率。", "F4F6EE"),
                calloutCell("落地目标", "颜色、字号、间距、组件语义直接沉淀成 token 与组件库。", "F8F6F2"),
              ],
            }),
          ],
        }),
        p(text("01 设计定位", { bold: true, size: 32 }), {
          heading: HeadingLevel.HEADING_1,
          pageBreakBefore: true,
          spacing: { after: 160 },
        }),
        p(
          [
            text("柏厚生活不是低价促销型电商，也不是只停留在概念图层面的艺术品牌。"),
            text(" 它更像一个有交付能力的生活方式服务品牌。", { bold: true }),
          ],
          { spacing: { after: 120 } },
        ),
        ...bullet([
          "温暖克制：避免高饱和色、大面积刺激对比，整体更偏奶油白、暖灰、木质棕和苔绿。",
          "空间感：界面要有留白和秩序，让商品图、空间图、场景图成为真正主角。",
          "专业可信：后台信息组织清楚，状态表达明确，减少只好看不好用的装饰性设计。",
          "生活方式感：小程序端要传达“空间、材质、温度、服务”的复合气质。",
        ]),
        p(text("双端表达建议", { bold: true, size: 26 }), {
          heading: HeadingLevel.HEADING_2,
          spacing: { after: 120 },
        }),
        infoTable(
          [
            ["维度", "小程序端", "后台管理端"],
            ["角色定位", "品牌展示与业务转化入口", "运营工具与信息管理中枢"],
            ["视觉重心", "图片、场景、Banner、预约与下单 CTA", "表格、表单、筛选、状态与批量操作"],
            ["版面节奏", "留白更大，信息密度更低", "信息密度更高，装饰更轻"],
            ["统一部分", "共享颜色、字体层级、圆角、状态语义", "共享颜色、字体层级、圆角、状态语义"],
          ],
          [1600, 3880, 3880],
        ),
        p(text("02 品牌与色彩", { bold: true, size: 32 }), {
          heading: HeadingLevel.HEADING_1,
          pageBreakBefore: true,
          spacing: { after: 160 },
        }),
        p(
          text(
            "推荐视觉方向是“暖中性现代家居”。避免科技蓝、荧光色、强营销感渐变，也避免过冷的极简黑金。主品牌色要稳，辅助色要柔，界面底色要给图片留空间。",
            { size: 22, color: colors.textSecondary },
          ),
          { spacing: { after: 180 } },
        ),
        paletteBoardTable(),
        infoTable(
          [
            ["色彩角色", "建议用途", "设计提醒"],
            ["Brand Primary / #6F5A45", "主按钮、价格强调、选中态、导航强调", "不要拿来铺整页背景，避免页面过重"],
            ["Brand Accent / #7D8A63", "设计师身份、场景推荐、轻提示区", "适合做辅助语气，不宜压过主 CTA"],
            ["Soft 系列", "卡片底、统计卡、分区背景、氛围衬底", "优先和白底叠用，制造层次感"],
            ["状态色", "成功、警告、异常、信息反馈", "错误色仅用于异常和删除，不参与主行动按钮"],
          ],
          [2400, 3360, 3600],
        ),
        p(text("03 字体、间距与秩序", { bold: true, size: 32 }), {
          heading: HeadingLevel.HEADING_1,
          pageBreakBefore: true,
          spacing: { after: 160 },
        }),
        p(
          text(
            "字体优先使用平台原生中文无衬线，保持稳定加载与跨端一致。区分层级时优先用字号、颜色和空间，不用过度加粗解决一切问题。",
            { size: 22, color: colors.textSecondary },
          ),
          { spacing: { after: 180 } },
        ),
        rhythmBoardTable(),
        infoTable(
          [
            ["系统维度", "建议", "适用说明"],
            ["小程序字号", "Display 28/36, H1 24/32, H2 20/28, Body 16/24, Caption 12/18", "强调浏览节奏和拇指操作可读性"],
            ["后台字号", "Page Title 24/32, Section 20/28, Body 14/22, Table 13/20", "强调信息密度和长时间操作舒适度"],
            ["间距 token", "4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48 / 64", "统一模块节奏，避免页面出现临时数值"],
            ["圆角体系", "6 / 8 / 12 / 16 / 20 / Pill", "小元素收敛，卡片和大图模块更柔和"],
          ],
          [1800, 3900, 3660],
        ),
        p(text("04 组件语气与界面氛围", { bold: true, size: 32 }), {
          heading: HeadingLevel.HEADING_1,
          pageBreakBefore: true,
          spacing: { after: 160 },
        }),
        p(
          text(
            "组件层面不追求“花”。真正的高级感来自按钮层级清楚、标签语义稳定、卡片边界适度、阴影只在必要处出现。",
            { size: 22, color: colors.textSecondary },
          ),
          { spacing: { after: 180 } },
        ),
        componentBoardTable(),
        ...bullet([
          "按钮分为 Primary / Secondary / Tertiary / Danger / Ghost 五类，页面里同时出现的强主按钮最好只保留一个。",
          "标签统一 24px 高度、12px 字号，依靠底色和文字颜色表达状态，不用花哨描边。",
          "小程序卡片强调图片、标题、副标题、价格和操作；后台卡片强调字段分组与视觉秩序。",
          "后台表格默认浅底浅边框，优先右侧固定操作列；不要用深色表头压重页面。",
          "简单编辑用弹窗，复杂编辑和详情对比用抽屉；移动端优先底部弹层。",
        ]),
        p(text("05 小程序与后台的版式建议", { bold: true, size: 32 }), {
          heading: HeadingLevel.HEADING_1,
          pageBreakBefore: true,
          spacing: { after: 160 },
        }),
        infoTable(
          [
            ["页面类型", "展示建议"],
            ["小程序首页", "品牌头图 -> 区域选择 -> 核心品类 -> 空间场景推荐 -> 设计师专区 -> 预约/留资入口。首屏不超过三层视觉重点。"],
            ["商品列表", "优先双列卡片，统一图片比例，筛选栏轻吸顶，不要把筛选做成厚重工具条。"],
            ["商品详情", "先给轮播图和核心价格，再分组展示参数、标签、空间场景；底部 CTA 固定。"],
            ["我的页面", "订单、预约、线索、身份状态做分组卡片，设计师身份和普通客户身份拉开视觉差异。"],
            ["后台列表页", "标题区 + 查询筛选区 + 批量操作区 + 表格区 + 分页区，信息优先，避免营销页风格。"],
            ["后台详情页", "标题与状态区 + 基础信息卡片 + 业务信息卡片 + 操作记录/状态流转区。"],
          ],
          [1800, 7560],
        ),
        p(text("06 落地优先级与协作建议", { bold: true, size: 32 }), {
          heading: HeadingLevel.HEADING_1,
          pageBreakBefore: true,
          spacing: { after: 160 },
        }),
        new Table({
          width: { size: 9360, type: WidthType.DXA },
          columnWidths: [4680, 4680],
          rows: [
            new TableRow({
              children: [
                calloutCell("一期优先统一", "颜色 token、字号字重、按钮体系、标签体系、卡片体系、商品卡、后台表格模板、后台详情模板。", "F8F3ED"),
                calloutCell("二期可补充", "图标库清单、图片裁切模板、图表规范、品牌宣传页专项规范、设计师端专属视觉规范。", "F4F6EE"),
              ],
            }),
          ],
        }),
        p(text("设计与开发协作方式", { bold: true, size: 26 }), {
          heading: HeadingLevel.HEADING_2,
          spacing: { after: 120 },
        }),
        ...bullet([
          "新页面先从现有 token 和组件里选型，再进入页面设计，不直接从零开画。",
          "若页面确实需要新组件，先判断是否可抽象为全局组件，再决定是否做页面私有样式。",
          "研发侧把颜色、圆角、间距沉淀成统一变量，避免在单页内继续出现临时色值和硬编码样式。",
          "若依 Vue3 后台优先基于 Element Plus 主题能力做品牌化，不重复发明基础控件。",
        ]),
        p(text("结论", { bold: true, size: 26 }), {
          heading: HeadingLevel.HEADING_2,
          spacing: { after: 120 },
        }),
        p(
          [
            text("这套设计系统的关键不在于做一份“看起来很满”的规范，而在于建立 "),
            text("可被复用的品牌基线", { bold: true }),
            text("。只要颜色、排版、组件语义和双端策略先统一，后续页面就能在同一品牌气质下持续扩展。"),
          ],
          { spacing: { after: 140 } },
        ),
        p(
          [
            text("源文档："),
            new ExternalHyperlink({
              link: "file:///Users/timer/2026开发/生活产品展示/docs/06-设计系统.md",
              children: [text("06-设计系统.md", { color: colors.brandPrimary, bold: true })],
            }),
          ],
          { spacing: { after: 0 } },
        ),
      ],
    },
  ],
});

fs.mkdirSync(outputDir, { recursive: true });

Packer.toBuffer(doc).then((buffer) => {
  fs.writeFileSync(outputPath, buffer);
  process.stdout.write(`${outputPath}\n`);
});
