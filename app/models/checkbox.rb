class CheckBox < UnscoredQuestion
  def edit
    html = "<form accept-charset="UTF-8" action="/questions/create" method="post">"
    html += "Type: <input id="question_type" name="question[type]" type="text" value="Scale" size="3" disabled="true" />"
    html += "Txt: <input id="question_txt" name="question[txt]" size="70" type="text" />"
    html += "Alternatives: <input id="question_alternatives" name="question[alternatives]" size="5" type="text" />"
    html += "Weight: <input id="question_weight" name="question[weight]" size="1" type="text" />"
    html += "<input name="commit" type="submit" value="Create/Edit" />"
    html += "</form>"
  end

  def view_question_text
    html = "Type: <input id="question_type" name="question[type]" type="text" value="Scale" size="3" disabled="true" />"
    html += "Txt: <input id="question_txt" name="question[txt]" size="70" type="text" disabled="true"/>"
    html += "Alternatives: <input id="question_alternatives" name="question[alternatives]" size="5" type="text" disabled="true"/>"
    html += "Weight: <input id="question_weight" name="question[weight]" size="1" type="text" disabled="true"/>"
  end

  def complete
    html = "Txt: <input id="question_txt" name="question[txt]" size="70" type="text" disabled="true"/>"
    alternatives = self.alternatives.splict('|')
    alternatives.each_with_index do |alternative, index|
      html += "<input type="radio" id="checkbox"" +index_to_s+ "name=" +alternative+ ">"
      html += alternative
    end
  end

  def view_completed_question(response_id)
    answer = Answer.where(question_id: self.id, response_id: response_id).first
    html = "Txt: <input id="question_txt" name="question[txt]" size="70" type="text" disabled="true"/>"
    alternatives = self.alternatives.splict('|')
    alternatives.each_with_index do |alternative, index|
      html += "<input type="radio" id="checkbox"" +index_to_s+ "name=" +alternative
      html += "checked="checked"" if answer.answer == index
      html += ">" + alternative
    end
  end

  def self.checked?(response_id)
    answer = Answer.where(question_id: self.id, response_id: response_id).first
    return answer.comment == '0'
  end
end
