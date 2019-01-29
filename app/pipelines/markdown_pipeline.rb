class MarkdownPipeline < Banzai::Pipeline
  def initialize(options = {})
    Rails.logger.info 'MarkdownPipeline#initialize'

    super(
      # As Markdown
      FrontmatterFilter,
      PHPInlinerFilter,
      InlineEscapeFilter,
      BlockEscapeFilter,
      ScreenshotFilter,
      AnchorFilter,
      AudioFilter,
      DynamicContentFilter,
      TooltipFilter,
      CollapsibleFilter,
      TabFilter.new(options),
      BuildingBlocksFilter,
      BuildingBlockFilter,
      CodeFilter,
      IndentFilter,
      ModalFilter,
      JsSequenceDiagramFilter,
      PartialFilter.new(options),
      TechioFilter,
      TutorialsFilter,
      BuildingBlockListFilter,
      ConceptListFilter,
      LanguageFilter,
      ColumnsFilter,
      MarkdownFilter.new(options),

      # As HTML
      UserPersonalizationFilter.new(options),
      HeadingFilter,
      LabelFilter,
      BreakFilter,
      UnfreezeFilter,
      IconFilter,
      ExternalLinkFilter,
      TutorialLinkFilter
    )
  end
end
