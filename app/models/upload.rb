class Upload < ActiveRecord::Base
	attr_accessible :name, :file 
  has_many :uploadsegments, :dependent => :destroy
  has_many :articles, :through => :uploadsegments
  has_attached_file :file
  before_save :parse_file
end
  def parse_file
    tempfile = file.queued_for_write[:original]
    doc = Nokogiri::XML(tempfile)
    parse_xml(doc)
  end
   def parse_xml(doc)
    doc.root.elements.each do |node|
      parse_uploads(node)
    end
  end
    def parse_uploads(node)
    if node.node_name.eql? 'item'
      node.elements.each do |node|
        parse_upload_segments(node)
      end
    end
  end
  def parse_upload_segments(node)
    if node.node_name.eql? 'seg'
      tmp_segment = Uploadsegment.new
      node.elements.each do |node|
        parse_articles(node,tmp_segment)
      end
      self.uploadsegments << tmp_segment
    end
  end
   def parse_articles(node,tmp_segment)
    if node.node_name.eql? 'block'
      tmp_article = Article.new
      node.elements.each do |node|
        tmp_article.title = node.text.to_s if node.name.eql? 'title'
        tmp_article.author = node.text.to_s if node.name.eql? 'author'
        tmp_article.content = node.text.to_s if node.name.eql? 'content'
        tmp_article.created_at = node.text.to_s if node.name.eql? 'created'
      end
      tmp_segment.articles << tmp_article
    end
  end