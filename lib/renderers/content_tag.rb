module MarkupLounge
  class ContentTag < ClosedTag
    include ContentRendering
    
    def initialize(opts, &block)
      super
      if block_given?
        self.content = block
      else
        self.content = opts[:content]
      end
    end
    
    def id(identifier, &block)
      super(identifier)
      self.content = block if block_given?
      self
    end
    
    def c(*classes, &block)
      super(*classes)
      self.content = block if block_given?
      self
    end
    
    def head
      self.output << "#{indent}<#{type}#{rendered_attributes}>\n"
    end
    
    def foot
      self.output << "#{indent}</#{type}>\n"
    end
    
    def render_content
      view.level += 1
      if content.is_a?(Proc)
        content.call
      else
        view.buffer << Text.new(:view => view, :content => content) if content
      end
      view.render_buffer
      view.level -= 1
    end
  end
end