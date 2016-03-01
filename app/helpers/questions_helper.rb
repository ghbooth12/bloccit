module QuestionsHelper
  def message_resolved(question)
    if question.resolved
      "The question has resolved. :)"
    else
      "The question has not resolved yet. :("
    end
  end
end
