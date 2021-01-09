module Service

using ..Model, ..Mapper

function createPaper(obj)
    # obj = json dict
    @assert haskey(obj, :title) && !isempty(obj.title)
    @assert haskey(obj, :abst) && !isempty(obj.abst)
    @assert haskey(obj, :authors) && !isempty(obj.authors)
    @assert haskey(obj, :publishdate) && !isempty(obj.publishdate)

    paper = Paper(obj.title, obj.abst, obj.authors, obj.publishdate)
    Mapper.store!(paper)
    return paper
end

getPaper(id) = Mapper.get(id)

function updatePaper(id, updated)
    paper=Mapper.get(id)
    paper.title = updated.title
    paper.abst = updated.abst
    paper.authors = updated.authors
    paper.publishdate = updated.publishdate
    Mapper.store!(paper)
    return paper
end

function deletePaper(id)
    Mapper.delete(id)
    return
end


function pickPaperToRead()
    papers = Mapper.getAllPapers()
    leastTimesPicked = minimum(x -> x.timespicked, papers)
    leastPickedPapers = filter(x -> x.timespicked == leastTimesPicked, papers)
    pickedPaper = rand(leastPickedPapers)
    pickedPaper.timespicked += 1
    Mapper.store!(pickedPaper)
    return pickedPaper
end

end



